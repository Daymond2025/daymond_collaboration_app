import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daymond_collaboration_app/distributeur/constants/app_pages.dart';
import 'package:daymond_collaboration_app/distributeur/screens/auth/loginScreen.dart';

class OnboardingDistributeurScreen extends StatefulWidget {
  const OnboardingDistributeurScreen({super.key});

  @override
  State<OnboardingDistributeurScreen> createState() =>
      _OnboardingDistributeurScreenState();
}

class _OnboardingDistributeurScreenState
    extends State<OnboardingDistributeurScreen> {
  final PageController _pageController = PageController();
  final box = GetStorage();

  int _currentIndex = 0;
  bool _bottomSheetShown = false;

  final List<Map<String, dynamic>> _slides = [
    {
      'image': 'assets/images/A02.png',
      'title': 'DEVENEZ FOURNISSEUR POUR LES REVENDEURS EN LIGNE',
      'subtitle':
          'Une armée de revendeurs disponibles partout en Côte d’Ivoire prêt à vendre vos produits.',
      'buttonText': 'SUIVANT',
    },
    {
      'image': 'assets/images/A01.png',
      'title': 'UNE OPPORTUNITÉ UNIQUE POUR VENDRE PLUS',
      'subtitle':
          'Des milliers de revendeurs motivés prêts à proposer vos produits à leurs clients.',
      'buttonText': 'SUIVANT',
    },
    {
      'image': 'assets/images/A01.png',
      'title': 'PRÊT À COMMENCER ?',
      'subtitle': 'Avez-vous déjà créé un compte Diamond ou pas encore ?',
      'isLast': true,
    },
  ];

  void _nextPage() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showAuthBottomSheet() {
    if (_bottomSheetShown) return;

    setState(() => _bottomSheetShown = true);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Dites-nous, avez-vous déjà créé un compte Diamond ou pas encore ?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  box.write('onboarding_seen', true);
                  Get.offAllNamed(Routes.login);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.orange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  "Se connecter",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  box.write('onboarding_seen', true);
                  Get.offAllNamed(Routes.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text("Créer un compte"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _slides.length,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);

          if (index == 2 && !_bottomSheetShown) {
            // Affichage différé pour éviter conflits avec build
            Future.delayed(const Duration(milliseconds: 200), () {
              _showAuthBottomSheet();
            });
          }
        },
        itemBuilder: (context, index) {
          final slide = _slides[index];
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text(
                  slide['title'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    slide['image'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  slide['subtitle'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const Spacer(),
                if (slide['isLast'] == true)
                  const SizedBox(height: 80)
                else
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _slides.length,
                          (i) => Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color:
                                  _currentIndex == i
                                      ? Colors.orange
                                      : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size.fromHeight(45),
                        ),
                        child: Text(slide['buttonText'] ?? 'SUIVANT'),
                      ),
                    ],
                  ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
