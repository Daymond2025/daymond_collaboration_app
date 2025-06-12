import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:daymond_collaboration_app/collaboration/LoadingScreen.dart';
import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/check_network_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/profil/update_recruteur_profil.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/profil/badge_certifie_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilRecruteurScreen extends StatefulWidget {
  const ProfilRecruteurScreen({Key? key}) : super(key: key);

  @override
  State<ProfilRecruteurScreen> createState() => _ProfilRecruteurScreenState();
}

class _ProfilRecruteurScreenState extends State<ProfilRecruteurScreen> {
  RecruterFindModel _recruteur = RecruterFindModel();
  bool _loading = true;

  Future getRecruteurInfos() async {
    ApiResponse response = await user_services.getUserDetail();

    if (response.error == null) {
      setState(() {
        _recruteur = response.data as RecruterFindModel;
        _loading = false;
      });
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
      user_services.logout();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez vous conntecter. '),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Echec à la connexion. '),
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const CheckNetworkScreen()),
          (route) => false);
    }
  }

  Future<void> logoutRecruteur() async {
    print("[LOGOUT] Début de la déconnexion");

    await user_services.logout();

    if (!mounted) return;

    print("[LOGOUT] Redirection vers LoadingScreen()");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoadingScreen(),
      ),
      (route) => false,
    );
  }



  void DeleteUser(BuildContext context) async {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            barrierColor: primary,
            denyButtonText: 'Non',
            denyButtonColor: blue,
            confirmButtonText: 'Oui',
            confirmButtonColor: Colors.red,
            title: "Attention !!!",
            text: "Souhaitez-vous supprimer votre compte",
            onConfirm: () async {
              Navigator.pop(context);
              ButtomSetData(context, 'Suppression en cous ...');
              new Timer(const Duration(seconds: 1), () async {
                /*ApiResponse response = await user_services.DeleteUserAcount();
                if (response.error == null) {
                  new Timer(const Duration(seconds: 1), () async {
                    Navigator.pop(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => OnboardingScreen()),
                        (route) => false);
                  });
                } else {
                  Navigator.pop(context);
                  ArtSweetAlert.show(
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.danger,
                          title: "Oopp !",
                          text: "${response.error}"));
                }*/
              });
            }));
  }

  @override
  void initState() {
    super.initState();
    getRecruteurInfos();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text('Mon profil', style: TextStyle(color: Colors.black)),
        actions: [
          PopupMenuButton(
              constraints: const BoxConstraints(minWidth: 150),
              itemBuilder: (BuildContext context) => <PopupMenuItem>[
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          user_services.getRole().then((value) => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateRecruteurProfil()))
                              });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Icon(
                              FontAwesomeIcons.pencil,
                              size: 14,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.0),
                              child: const Text(
                                'Modifier',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        user_services.getUserId().then((value) => {
                              ArtSweetAlert.show(
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                      type: ArtSweetAlertType.info,
                                      barrierColor: primary,
                                      denyButtonText: 'Non',
                                      denyButtonColor: blue,
                                      confirmButtonText: 'Oui',
                                      confirmButtonColor: Colors.red,
                                      title: "Info !!!",
                                      text: "Souhaitez-vous vous déconnecter ?",
                                      onConfirm: () async {
                                        Navigator.pop(context);
                                        ButtomSetData(
                                            context, 'Déconnexion en cous ...');
                                        new Timer(const Duration(seconds: 1),
                                            () {
                                          logoutRecruteur();
                                        });
                                      })),
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.powerOff,
                              size: 14,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.0),
                              child: const Text('Déconnecter',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        /*user_services
                            .getRole()
                            .then((value) => {DeleteUser(context)});*/
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.trash,
                              size: 14,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.0),
                              child: const Text('Supprimer',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])
        ],
      ),
      backgroundColor: Colors.white,
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: bludeBold,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(17),
                          bottomRight: Radius.circular(17))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width / 4,
                          height: size.width / 4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: _recruteur.picture == null
                                    ? AssetImage('assets/images/user.png')
                                    : NetworkImage(_recruteur.picture != null
                                        ? '${_recruteur.picture}'
                                        : imgUserDefault),
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                  width: size.width < 350 ? 2 : 3,
                                  color: Colors.white)),
                        ),
                        Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                "${_recruteur.entity!.firstName} ${_recruteur.entity!.lastName}",
                                style: TextStyle(
                                    fontSize: size.width < 350 ? 15 : 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Membre depuis le ${FormatDate('${_recruteur.createdAt}')}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width < 350 ? 10 : 12),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width < 350 ? 12 : 12,
                      bottom: size.height * 0.16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        leading: Image.asset(
                          'assets/images/ci.png',
                          width: 30,
                        ),
                        title: Row(
                          children: [
                            _recruteur.entity!.city!.country == null
                                ? Text("")
                                : Text(
                                    "${_recruteur.entity!.city!.country!.name} "),
                            Expanded(
                                child: Text(
                              "${_recruteur.entity!.city!.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.call,
                          color: Colors.black,
                          size: 30,
                        ),
                        title: Text("${_recruteur.phoneNumber}"),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.black,
                          size: 30,
                        ),
                        title: Text("${_recruteur.email}"),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () => {
                        _recruteur.entity!.stars == 1
                            ? BadgeCertifie(
                                context,
                                '${_recruteur.entity!.stars}',
                                FormatDate('${_recruteur.createdAt}'))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BadgeCertifieScreen())),
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/badge_CERTIFIER.png',
                            width: size.width < 350 ? 40 : 60,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _recruteur.entity!.stars == 1
                              ? Column(
                                  children: [
                                    Text(
                                      "Badge certifé",
                                      style: TextStyle(color: blue),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                          "Date d'expiration : ${FormatDateHour("${_recruteur.createdAt}")}"),
                                    ),
                                  ],
                                )
                              : Text(
                                  "Obtenir un badge certifié",
                                  style: TextStyle(
                                      color: blue, fontWeight: FontWeight.bold),
                                ),
                          //SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

void BadgeCertifie(BuildContext context, String num_badge, String date_expire) {
  Size size = MediaQuery.of(context).size;
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    content: Stack(
      children: [
        Container(
          height: size.height * 0.41,
          width: size.width,
          margin: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/badge_CERTIFIER.png",
                            ),
                            fit: BoxFit.contain)),
                    height: size.height * 0.18,
                    width: size.width * 0.5,
                  ),
                ),
                Text("Votre compte est certifié",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: blue)),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.06),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text('N° du badge : ${num_badge}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Date d'expiration : ${date_expire}"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: -4,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 18,
              )),
        )
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
