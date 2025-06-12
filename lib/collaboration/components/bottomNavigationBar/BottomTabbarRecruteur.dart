// ignore_for_file: file_names, must_be_immutable

import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/provider/controllers/controller_path.dart';
import 'package:daymond_collaboration_app/collaboration/screen/home_recruteurs_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/post/post_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/addSellers/add_new_sellers_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/parametres/parametreScreen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/statistique/statistique_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomTabbarRecruteur extends StatefulWidget {
  BottomTabbarRecruteur({Key? key, required this.selectedIndex})
      : super(key: key);
  int selectedIndex;

  @override
  State<BottomTabbarRecruteur> createState() =>
      _BottomTabbarCompteVendeurState();
}

class _BottomTabbarCompteVendeurState extends State<BottomTabbarRecruteur> {
  final CityController cityController = Get.put(CityController());
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: white,
        currentIndex: widget.selectedIndex,
        onTap: (value) {
          setState(() {
            widget.selectedIndex = value;
            if (value == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeRecruteurScreen()));
            }
            if (value == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StatistiqueScreen()));
            }
            if (value == 2) {
              cityController.getCities();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewSellersScreen()));
            }
            if (value == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostsScreen()));
            }
            if (value == 4) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ParametreScreen()));
            }
          });
        },
        selectedLabelStyle: TextStyle(color: blue),
        unselectedLabelStyle: TextStyle(color: Colors.black87),
        unselectedIconTheme: IconThemeData(
          color: black,
        ),
        unselectedItemColor: black,
        selectedIconTheme: IconThemeData(color: blue),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Accueil',
            icon: Image.asset(
              'assets/images/accueil.png',
              width: 20,
              color: widget.selectedIndex == 0 ? blue : null,
            ),
          ),
          BottomNavigationBarItem(
            label: 'statistique',
            icon: Image.asset(
              'assets/images/statistique.png',
              width: 28,
              color: widget.selectedIndex == 1 ? blue : null,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Image.asset(
              'assets/images/ajout.png',
              width: 40,
              color: widget.selectedIndex == 2 ? blue : null,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Chaine',
            icon: Image.asset(
              'assets/images/actu.png',
              width: 30,
              color: widget.selectedIndex == 3 ? blue : null,
            ),
          ),
          BottomNavigationBarItem(
            tooltip: 'Profil',
            label: 'Compte',
            icon: Image.asset(
              'assets/images/compte.png',
              width: 20,
              color: widget.selectedIndex == 4 ? blue : null,
            ),
          )
        ]);
  }
}
