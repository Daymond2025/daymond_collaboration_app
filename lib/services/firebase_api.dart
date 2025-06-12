import 'dart:convert';
import 'dart:io'; // ✅ Pour utiliser Platform.isAndroid ou Platform.isIOS
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:daymond_collaboration_app/notification_screen.dart';
import 'package:daymond_collaboration_app/main.dart';
import 'package:http/http.dart' as http;

/// Fonction exécutée quand une notif arrive en background (app fermée)
Future<void> onBackgroundMessage(RemoteMessage message) async {
  debugPrint('📨 [BG] Title: ${message.notification?.title}');
  debugPrint('📨 [BG] Body: ${message.notification?.body}');
  debugPrint('📨 [BG] Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Canal de notifications Android (important)
  static const AndroidNotificationChannel androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  /// Gère l'ouverture d'une notification
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }

  /// Initialisation des notifications locales (popup native)
  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null) {
          handleMessage(RemoteMessage.fromMap(jsonDecode(payload)));
        }
      },
    );

    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(androidChannel);
  }

  /// Initialisation complète des notifications Firebase
  Future<void> initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // App complètement fermée
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // App en arrière-plan puis relancée
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Message reçu en arrière-plan
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    // Message reçu quand app au premier plan
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  /// Récupération du token FCM pour un utilisateur
  Future<String?> getToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      debugPrint('🎯 Token FCM récupéré: $token');
      return token;
    } catch (e) {
      debugPrint('❌ Erreur lors de la récupération du token FCM: $e');
      return null;
    }
  }

  /// Envoi du token au backend Laravel (avec authentification Bearer)
  Future<void> sendTokenToBackend(String token, String bearerToken) async {
    if (token.isEmpty || bearerToken.isEmpty) {
      debugPrint('⚠️ Token ou bearerToken vide, envoi annulé');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://v2.daymondboutique.com/api/v2/fcm-token'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'token': token,
          'device_type': Platform.isAndroid ? 'android' : 'ios',
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('✅ Token FCM envoyé avec succès au backend');
      } else {
        debugPrint(
          '❌ Échec de l\'envoi du token: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('❌ Exception HTTP lors de l\'envoi du token: $e');
    }
  }

  /// Initialisation générale appelée au démarrage de l'app
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await getToken();

    debugPrint('📡 Token FCM récupéré au démarrage : $fcmToken');

    await initPushNotifications();
    await initLocalNotifications();
  }
}
