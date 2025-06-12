import 'package:daymond_collaboration_app/distributeur/onboarding_distributeur_screen.dart';
import 'package:daymond_collaboration_app/distributeur/screens/newScreens/connexion/connexion_widget.dart';
import 'package:get/get.dart';

import '../screens/auth/loginScreen.dart';

import '../screens/views/detailNeworderScreen.dart';
import '../screens/views/homeScreen.dart';
import 'splachscren.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.bigin;

  static final routes = [
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingDistributeurScreen(),
    ),

    GetPage(
      name: Routes.login,
      page: () => const ConnexionWidget(),
    ),
    GetPage(
      name: Routes.bigin,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeSreen(),
    ),
  ];
}
