import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_pages.dart';
import '../constants/constantApp.dart';
import 'package:daymond_collaboration_app/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/usermodel.dart';
import 'GetUsercontroller.dart';

class LoginController extends GetxController {
  //final GetUserController authController = Get.put(GetUserController());
  var user = Rxn<User>();
  var option = Rxn<Option>();
  var isLoading = false.obs; // Observable pour suivre l'état de chargement
  var isLoadinguser = false.obs;
  String? token; // Token stocké en mémoire
  int? admin;
  String? auths; //user is admin

  bool isLoggedIn() {
    return isLoadinguser.value;
  }

  // You can also add methods to log in and log out the user
  void loginUsers() {
    isLoadinguser.value = true;
  }

  void logoutUser() {
    isLoadinguser.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Vérification au démarrage
  }

  Future<void> loginUser(String email, String password) async {
    isLoading(true); // Démarre le chargement
    try {
      final url = Uri.parse(AppConstants.loginUrl);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final data = jsonDecode(response.body);
        print(data);
        user.value = User.fromJson(data['data']['user']);
        print(' $data');
        token = data['data']['token']; // Stocker le token en mémoire
        option.value = Option.fromJson(data['data']['option']);
        admin = option.value!.isAdmin;
        auths = option.value!.role;
        // ✅ Envoi d'une notification push après login fournisseur
        final userId = user.value?.id;
        final bearerToken = token ?? '';
        print('🔎 userId récupéré : $userId');
        print('🔎 bearerToken récupéré : ${bearerToken.substring(0, 20)}...');

        if (userId != null && bearerToken.isNotEmpty) {
          try {
            // ✅ 1. Récupérer le token FCM
            final fcmToken = await FirebaseMessaging.instance.getToken();
            print('🎯 Token FCM actuel : $fcmToken');

            // ✅ 2. Envoi vers Laravel
            final responseFcm = await http.post(
              Uri.parse('https://v2.daymondboutique.com/api/v2/fcm-token'),
              headers: {
                'Authorization': 'Bearer $bearerToken',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                'token': fcmToken,
                'device_type': Platform.isAndroid ? 'android' : 'ios',
              }),
            );

            if (responseFcm.statusCode == 200) {
              print('✅ Token FCM envoyé au backend avec succès');
            } else {
              print('❌ Échec d’envoi du token FCM');
              print('🧾 Code : ${responseFcm.statusCode}');
              print('📨 Body : ${responseFcm.body}');
            }

            // ✅ 3. Test de notification de bienvenue
            print('📢 Envoi d\'une notification de bienvenue...');
            await NotificationService.sendPushNotification(
              userId: userId,
              title: 'Bienvenue 👋',
              body: 'Connexion réussie sur votre compte fournisseur.',
              bearerToken: bearerToken,
            );
            print('✅ Notification envoyée');
          } catch (e) {
            print('❌ Exception durant l’envoi du token FCM ou notification : $e');
          }
        } else {
          print('❌ userId ou bearerToken manquant. Envoi annulé');
        }


        print('object $token');
        _saveAndRedirectToHome(token);
        _saveIsAdmin(admin, auths);
        // Rediriger vers la page d'accueil
      } else {
        EasyLoading.dismiss();
        print('Lerreur ${response.body}');
        Get.snackbar('Erreur', 'Erreur de connexion, veuillez réessayer.');
      }
    } finally {
      isLoading(false); // Arrête le chargement
    }
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedToken = prefs.getString('token');
    int? lastLoginTime = prefs.getInt('lastLoginTime');

    if (savedToken != null && lastLoginTime != null) {
      // Vérifier si le token est encore valide (ici, par exemple, un token est considéré expiré après 24h)
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      const expirationDuration =
          24 * 60 * 60 * 1000; // 24 heures en millisecondes

      if (currentTime - lastLoginTime < expirationDuration) {
        // Token encore valide, rediriger vers la page d'accueil
        token = savedToken;
        Get.toNamed(Routes.home);
      } else {
        // Token expiré, rediriger vers la page de connexion
        Get.offNamed(Routes.login);
      }
    } else {
      // Aucun token trouvé, rediriger vers la page de connexion
      Get.offNamed(Routes.login);
    }
  }

  void _saveAndRedirectToHome(String? token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', token ?? '');

    setUserSession();
    // Enregistrement de l'heure de connexion
    await pref.setInt('lastLoginTime', DateTime.now().millisecondsSinceEpoch);

    Get.offNamed(Routes.home);
  }

  void _saveIsAdmin(int? isadmin, String? auths) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('admin', admin ?? 0);
    await pref.setString('role', auths ?? '');

    setUserSession();
    // Enregistrement de l'heure de connexion
    await pref.setInt('lastLoginTime', DateTime.now().millisecondsSinceEpoch);

    Get.offNamed(Routes.home);
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // Supprimer les données de session (par exemple 'admin', 'lastLoginTime', etc.)
    await pref.remove('admin');
    await pref.remove('role');
    await pref.remove('lastLoginTime');
    // Ajoutez ici d'autres clés que vous voulez supprimer
    // await pref.remove('other_key');

    // Optionnel: Si vous voulez effacer toutes les préférences stockées
    await pref.clear();

    // Rediriger vers la page de login après la déconnexion
    Get.offAllNamed('/login');
  }
}
