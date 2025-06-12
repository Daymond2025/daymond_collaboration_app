import 'dart:convert';
import 'dart:io';

import 'package:daymond_collaboration_app/collaboration/components/bottomNavigationBar/BottomTabbarRecruteur.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/statistique_model.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/statistique/levelStatsScreen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/statistique/levelStatsScreenNiveaux0.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatistiqueScreen extends StatefulWidget {
  const StatistiqueScreen({Key? key}) : super(key: key);

  @override
  State<StatistiqueScreen> createState() => _StatistiqueScreenState();
}

class _StatistiqueScreenState extends State<StatistiqueScreen> {
  String somme_niveau0 = '0';
  String somme_niveau1 = '0';
  String somme_niveau2 = '0';
  String somme_niveau3 = '0';
  String somme_niveau4 = '0';
  String somme_niveau5 = '0';
  String? some_sellers;
  String? solde_compte;
  String? some_sellers_lien_rompus;
  String? some_sellers_lien_actifs;
  bool _loading = true;
  StatistiqueModel statistiqueModel = StatistiqueModel();
  Future getStatistiqueInfos() async {
    final token = await user_services.getToken();
    final response =
        await http.get(Uri.parse('$apiUrl/recruiter/stats'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    final reponseDecode = json.decode(response.body);
    statistiqueModel = StatistiqueModel.fromJson(reponseDecode);
    // print(statistiqueModel);
    if (response.statusCode == 200) {
      setState(() {
        somme_niveau0 =
            statistiqueModel.levelsStats!.level0Stats!.count.toString();
        // print(somme_niveau0);
        somme_niveau1 =
            statistiqueModel.levelsStats!.level1Stats!.count.toString();
        somme_niveau2 =
            statistiqueModel.levelsStats!.level2Stats!.count.toString();
        somme_niveau3 =
            statistiqueModel.levelsStats!.level3Stats!.count.toString();
        somme_niveau4 =
            statistiqueModel.levelsStats!.level4Stats!.count.toString();
        somme_niveau5 =
            statistiqueModel.levelsStats!.level5Stats!.count.toString();
        some_sellers =
            statistiqueModel.levelsStats!.level0Stats!.count.toString();
        solde_compte = statistiqueModel.amountTotal.toString();
        some_sellers_lien_rompus = statistiqueModel.inactiveSellers.toString();
        some_sellers_lien_actifs = statistiqueModel.activeSellers.toString();
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatistiqueInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(),
                  child: Stack(
                    children: [
                      Container(
                        height: 120,
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.only(top: 40),
                        decoration: const BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'STATISTIQUE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width / 1.08,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: Offset(0, 1.5),
                                  color: Colors.grey,
                                ),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Montant reçu',
                                    style: TextStyle(
                                      color: blue,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '${solde_compte}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 9, 54, 236),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' CFA',
                                          style: TextStyle(
                                              color: blue, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black12,
                                    height: 2,
                                    width: 130,
                                  ),
                                  Text(
                                    'Niveau 0',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LevelStatsNiveaux0Screen(
                                                    title: 'Niveau 0',
                                                    sommeNiveaux:
                                                        statistiqueModel
                                                            .levelsStats!
                                                            .level0Stats!
                                                            .sellersStats!
                                                            .length
                                                            .toString(),
                                                    count_level: '0',
                                                    sellersStats:
                                                        statistiqueModel
                                                            .levelsStats!
                                                            .level0Stats!
                                                            .sellersStats,
                                                  )));
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          '${somme_niveau0}',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 9, 54, 236),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //cercle
                              Column(
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 4),
                                        height: 110.0, // height of the button
                                        width: 130.0, // width of the button
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: blue, width: 5),
                                            shape: BoxShape.circle),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin:
                                            const EdgeInsets.only(bottom: 4),
                                        padding: const EdgeInsets.only(
                                          top: 15,
                                        ),
                                        height: 100.0, // height of the button
                                        width: 100.0, // width of the button
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black26,
                                                width: 3),
                                            shape: BoxShape.circle),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${some_sellers}',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 9, 54, 236),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Vendeurs',
                                              style: TextStyle(
                                                  color: blue, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 1,
                                        right: 1,
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .fiber_manual_record_outlined,
                                                        color: Colors.pink,
                                                        size: 15,
                                                      ),
                                                      Text(
                                                        '${some_sellers_lien_actifs}',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    9,
                                                                    54,
                                                                    236),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text(
                                                    'Liens Actifs',
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .fiber_manual_record_outlined,
                                                        color: Colors.green,
                                                        size: 15,
                                                      ),
                                                      Text(
                                                        '${some_sellers_lien_rompus}',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    9,
                                                                    54,
                                                                    236),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text(
                                                    'Liens Rompus',
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //niveau 5
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LevelStatsScreen(
                                        title: 'Niveau 5',
                                        sommeNiveaux: '${somme_niveau5}',
                                        count_level: '5',
                                        sellersStats: statistiqueModel
                                            .levelsStats!
                                            .level5Stats!
                                            .sellersStats,
                                      )));
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Niveau 5',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xffF5F6F8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      color: blue,
                                      width: somme_niveau5 == '0'
                                          ? 10
                                          : double.parse(somme_niveau5) * 15,
                                      child: Text(
                                        '${somme_niveau5}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //niveau 4
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LevelStatsScreen(
                                        title: 'Niveau 4',
                                        sommeNiveaux: '${somme_niveau4}',
                                        count_level: '4',
                                        sellersStats: statistiqueModel
                                            .levelsStats!
                                            .level4Stats!
                                            .sellersStats,
                                      )));
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Niveau 4',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xffF5F6F8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      color: blue,
                                      width: somme_niveau4 == '0'
                                          ? 10
                                          : double.parse(somme_niveau4) * 15,
                                      child: Text(
                                        '${somme_niveau4}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //niveau 3
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LevelStatsScreen(
                                        title: 'Niveau 3',
                                        sommeNiveaux: '${somme_niveau3}',
                                        count_level: '3',
                                        sellersStats: statistiqueModel
                                            .levelsStats!
                                            .level3Stats!
                                            .sellersStats,
                                      )));
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Niveau 3',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xffF5F6F8),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      color: blue,
                                      width: somme_niveau3 == '0'
                                          ? 10
                                          : double.parse(somme_niveau3) * 15,
                                      child: Text(
                                        '${somme_niveau3}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //niveau 2
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LevelStatsScreen(
                                        title: 'Niveau 2',
                                        sommeNiveaux: '${somme_niveau2}',
                                        count_level: '2',
                                        sellersStats: statistiqueModel
                                            .levelsStats!
                                            .level2Stats!
                                            .sellersStats,
                                      )));
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Niveau 2',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xffF5F6F8),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      color: blue,
                                      width: somme_niveau2 == '0'
                                          ? 10
                                          : double.parse(somme_niveau2) * 15,
                                      child: Text(
                                        '${somme_niveau2}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // niveau 1
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LevelStatsScreen(
                                        title: 'Niveau 1',
                                        sommeNiveaux: '${somme_niveau1}',
                                        count_level: '1',
                                        sellersStats: statistiqueModel
                                            .levelsStats!
                                            .level1Stats!
                                            .sellersStats,
                                      )));
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Niveau 1',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xffF5F6F8),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      color: blue,
                                      width: somme_niveau1 == '0'
                                          ? 10
                                          : double.parse(somme_niveau1) * 15,
                                      child: Text(
                                        '${somme_niveau1}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomTabbarRecruteur(
        selectedIndex: 1,
      ),
    );
  }
}
