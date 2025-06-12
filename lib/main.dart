import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '/services/firebase_api.dart';
import 'notification_screen.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'accueil_role_screen.dart'; // On le crée juste après

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialise correctement la locale
  await initializeDateFormatting('fr_FR', null);
  Intl.defaultLocale = 'fr_FR';

  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daymond Unifié',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const AccueilRoleScreen(), // Appel de l’écran d’accueil
      navigatorKey: navigatorKey,
      routes: {
        NotificationScreen.route: (context) => const NotificationScreen(),
      },
    );
  }
}
