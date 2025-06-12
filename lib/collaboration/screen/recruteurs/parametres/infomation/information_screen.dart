import 'package:flutter/material.dart';

import 'Compte fournisseur/compte_fournisseur.dart';
import 'Compte vendeur/compte_vendeur.dart';
import 'badge certifier/badge_certifier.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({
    super.key,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          title: Container(
            padding: const EdgeInsets.only(top: 45),
            alignment: Alignment.topCenter,
            child: const Text(
              'Plus d\'informations',
              style: TextStyle(fontSize: 15),
            ),
          ),
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          //Recruteur
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15, top: 20, bottom: 15),
            decoration: BoxDecoration(color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompteVendeur(),
                  ),
                );
              },
              child: const Text(
                'Compte vendeur',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          Container(
            color: Colors.black26,
            height: 1,
          ),
          //Ambassadeur
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15, top: 20, bottom: 15),
            decoration: BoxDecoration(color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompteFournisseur(),
                  ),
                );
              },
              child: const Text(
                'Compte fournisseur',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Container(
            color: Colors.black26,
            height: 1,
          ),
          //Fournisseur
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15, top: 20, bottom: 15),
            decoration: const BoxDecoration(color: Colors.white),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BadgeCertifier(),
                  ),
                );
              },
              child: const Text(
                'Badge certifié',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
