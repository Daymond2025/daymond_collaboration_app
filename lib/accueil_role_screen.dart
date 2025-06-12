import 'package:flutter/material.dart';
import 'collaboration/main_recruteur.dart'; 
import 'distributeur/main_distributeur.dart'; 
import 'package:google_fonts/google_fonts.dart';

//import 'package:daymond_collaboration_app/distributeur/constants/constantApp.dart';


class AccueilRoleScreen extends StatelessWidget {
  const AccueilRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 90),
            Center(
              child: Image.asset(
                'assets/images/main_collab.png',
                height: 70,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'BIENVENUE, SUR DAYMOND\nCOLLABORATION',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sélectionnez votre statut\npour accéder à votre compte',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 6),
            const Icon(Icons.keyboard_arrow_down, size: 24),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  RoleCard(
                    color: Color(0xFFE0F0FF),
                    borderColor: Color(0xFFB0D3F1),
                    title: 'Je suis Recruteur',
                    titleColor: Colors.blue,
                    descriptionWidget: RecruteurText(),
                    imagePath: 'assets/images/Calque12.png',
                    chevronColor: Colors.blue,
                    isRecruteur: true,
                  ),
                  SizedBox(height: 16),
                  RoleCard(
                    color: Color(0xFFFFF4E0),
                    borderColor: Color(0xFFF3C57A),
                    title: 'Je suis Distributeur',
                    titleColor: Colors.orange,
                    descriptionWidget: DistributeurText(),
                    imagePath: 'assets/images/DS 1.png',
                    chevronColor: Colors.orange,
                    isRecruteur: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final String title;
  final Color titleColor;
  final Widget descriptionWidget;
  final String imagePath;
  final Color chevronColor;
  final bool isRecruteur;

  const RoleCard({
    super.key,
    required this.color,
    required this.borderColor,
    required this.title,
    required this.titleColor,
    required this.descriptionWidget,
    required this.imagePath,
    required this.chevronColor,
    required this.isRecruteur,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) =>
                    isRecruteur
                        ? const RecruteurApp()
                        : const DistributeurApp(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  descriptionWidget,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '»»',
                style: TextStyle(
                  fontSize: 22,
                  color: chevronColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecruteurText extends StatelessWidget {
  const RecruteurText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Rejoingez-nous, Identifiez\ninformez et recrutez les Revendeurs autour\nde vous.Transformez votre réseaux en revenus!',
      style: TextStyle(fontSize: 9, height: 1.2),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class DistributeurText extends StatelessWidget {
  const DistributeurText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 9, color: Colors.black, height: 1.2),
        children: [
          TextSpan(text: 'Des milliers de '),
          TextSpan(
            text: 'revendeurs ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                'n’attendent que vos produits pour inonder le marché en ligne. Ne passer pas à côté - ',
          ),
          TextSpan(
            text: 'Connectez-vous ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'et profitez de tous les avantages !',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }
}
