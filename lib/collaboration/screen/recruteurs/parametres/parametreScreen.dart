import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/bottomNavigationBar/BottomTabbarRecruteur.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
// import 'package:daymond_collaboration_app/collaboration/models/recruteur.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/check_network_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/parametres/CallCenter.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/parametres/ConditionUsing.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/parametres/infomation/badge%20certifier/badge_certifier.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/parametres/moreInfos.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/profil/profil_recruteurs_screen.dart';
import 'package:flutter/material.dart';

class ParametreScreen extends StatefulWidget {
  const ParametreScreen({Key? key}) : super(key: key);

  @override
  State<ParametreScreen> createState() => _ParametreScreenState();
}

class _ParametreScreenState extends State<ParametreScreen> {
  String Temps = "";

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

  double _doubleYourTime = TimeOfDay(hour: 12, minute: 59).hour.toDouble() +
      (TimeOfDay(hour: 12, minute: 59).minute.toDouble() / 60);
  double _doubleNowTime = TimeOfDay.now().hour.toDouble() +
      (TimeOfDay.now().minute.toDouble() / 60);

  @override
  void initState() {
    if (_doubleYourTime - _doubleNowTime > 0) {
      setState(() {
        Temps = 'Bonjour';
      });
    } else {
      setState(() {
        Temps = "Bonsoir";
      });
    }
    super.initState();
    getRecruteurInfos();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _loading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
            bottomNavigationBar: BottomTabbarRecruteur(
              selectedIndex: 4,
            ),
          )
        : Scaffold(
            backgroundColor: grey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 40,
              primary: true,
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 30, left: 20, right: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilRecruteurScreen())),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: size.height * 0.06),
                                    child: Text(
                                      Temps.toString(),
                                      style: TextStyle(
                                          color: blue,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage: _recruteur.picture != null
                                        ? NetworkImage('${_recruteur.picture}')
                                        : AssetImage("assets/images/user.png"),
                                  ),
                                ],
                              ),
                              Positioned(
                                  top: size.height * 0.08,
                                  width: size.width,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        '${_recruteur.entity!.firstName} ${_recruteur.entity!.lastName}',
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Column(children: [
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MoreInfos()));
                            }),
                            child: ListTile(
                                title: const Text("Plus d'informations"),
                                leading: Icon(Icons.info_outline)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 60.0),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BadgeCertifier()));
                            }),
                            child: ListTile(
                                title: const Text("Obtenir un badge certifié"),
                                leading: Image.asset(
                                  'assets/images/badge_CERTIFIER.png',
                                  width: 20,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 60.0),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CentreAssistant()));
                            }),
                            child: ListTile(
                                title: const Text("Centre d'assistance"),
                                leading: ImageIcon(
                                  color: blue,
                                  AssetImage(
                                    'assets/images/live-chat.png',
                                  ),
                                )),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConditionUsing()));
                      }),
                      child: ListTile(
                          title: const Text("Conditions d'utilisation"),
                          leading: ImageIcon(
                            AssetImage('assets/images/clipboard.png'),
                          )),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomTabbarRecruteur(
              selectedIndex: 4,
            ),
          );
  }
}
