import 'dart:async';

import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/bottomNavigationBar/BottomTabbarRecruteur.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/components/skeletonLaoding.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:daymond_collaboration_app/collaboration/models/wallet_model.dart';
import 'package:daymond_collaboration_app/collaboration/screen/portefeuilles/portefeuille_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/addSellers/add_new_sellers_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/check_network_screen.dart';
// import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/details_vendeurs_niveaux.dart';
// import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/details_vendeurs_niveaux.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/details_vendeurs_niveaux_home.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_seller.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeRecruteurScreen extends StatefulWidget {
  const HomeRecruteurScreen({Key? key}) : super(key: key);

  @override
  State<HomeRecruteurScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeRecruteurScreen> {
  //////////////////// get user solde ///////////////
  List<dynamic> array = [];
  final user_service = UserService();
  final seller_service = ServiceSeller();

  List<dynamic> array_actifs = [];
  List<dynamic> array_rompus = [];
  Wallet wallet = Wallet();
  Future<void> getBalanceUser() async {
    ApiResponse response = await user_service.getBalance();

    if (response.error == null) {
      final _data = response.data as dynamic;
      // print(_data);
      // print(_data);
      setState(() {
        somme = _data['wallet']['amount'].toString();
        sommeToDay = _data['amount_today'].toString();
        isLaoding = false;
      });
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
      user_service.logout();

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

  /////////////////////// get all seller by recrutetus //////////////
  Future<List<SellerModel>> getNewSeller() async {
    final response = await seller_service.getSeller();
    var data = response.cast<Map<String, dynamic>>();
    setState(() {
      array_actifs = data;
    });
    return data.map<SellerModel>((json) => SellerModel.fromJson(json)).toList();
  }

  /////////////////////// get all seller by recrutetus liens rompus //////////////
  Future<List<SellerModel>> getSellerLienRompus() async {
    final response = await seller_service.getSellerLienRompus();
    var data = response.cast<Map<String, dynamic>>();
    setState(() {
      array_rompus = data;
    });
    return data.map<SellerModel>((json) => SellerModel.fromJson(json)).toList();
  }

  // This widget is the root of your application.
  late Future<List<SellerModel>> futureNewSeller;
  late Future<List<SellerModel>> futureSellerLienRompus;

  @override
  void initState() {
    super.initState();
    getBalanceUser();
    futureNewSeller = getNewSeller();
    futureSellerLienRompus = getSellerLienRompus();
    initializeDateFormatting('fr_FR', null).then((_) => now);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: array_actifs.length == 0 ? white : grey,
        appBar: isLaoding
            ? AppBar(
                backgroundColor: white,
                elevation: 0,
              )
            : AppBar(
                backgroundColor: white,
                elevation: 0,
                automaticallyImplyLeading: false,
                bottom: PreferredSize(
                  preferredSize: isLaoding
                      ? Size.fromHeight(0)
                      : Size.fromHeight(size.height * 0.27),
                  child: isLaoding
                      ? Center(child: Container())
                      : Container(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: size.height * 0.2,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        //color: Color.fromRGBO(1, 22, 103, 10),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  Positioned(
                                    top: size.height * 0.02,
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PortefeuilleScreen())),
                                      child: Container(
                                        padding: EdgeInsets.zero,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          height: 120,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          decoration: BoxDecoration(
                                            color: white,
                                            border: Border.all(
                                                color: Colors.grey.shade100),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade200
                                                    .withOpacity(0.4),
                                                spreadRadius: -1,
                                                blurRadius: 9,
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              //total
                                              Positioned(
                                                top: 8,
                                                left: 20,
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                        'assets/images/portefeuille_fond.png',
                                                        width: 20),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Soldes',
                                                            style: TextStyle(
                                                                color: black,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 50,
                                                left: 20,
                                                child: Container(
                                                  padding: EdgeInsets.zero,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      90,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${somme}',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff1E68FF),
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Container(
                                                            height: 20,
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Text(
                                                              '   CFA',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff1E68FF),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              //date dernier transaction
                                              Positioned(
                                                bottom: 50,
                                                right: 10,
                                                child: sommeToDay != 0
                                                    ? Column(
                                                        children: [
                                                          Text(
                                                            'Aujourd\'hui',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            '+ $sommeToDay Fr',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff1E68FF)),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, left: 8, right: 8, top: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffF5F6F8),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 4.0, right: 4, bottom: 4, top: 4),
                                    child: TabBar(
                                        labelColor: white,
                                        unselectedLabelColor: black,
                                        dividerHeight: 0,
                                        indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              50), // Creates border
                                          color: blue,
                                          boxShadow: [
                                            BoxShadow(
                                              color: white.withOpacity(1),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0.8, 0.5),
                                            ),
                                          ],
                                        ),
                                        tabs: [
                                          Tab(
                                            child: FutureBuilder<
                                                List<SellerModel>>(
                                              future: futureNewSeller,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        'Mes recrus',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                          '${snapshot.data!.length}')
                                                    ],
                                                  );
                                                } else {
                                                  return Center(
                                                      child: Container());
                                                }
                                              },
                                            ),
                                          ),
                                          Tab(
                                            child: FutureBuilder<
                                                List<SellerModel>>(
                                              future: futureSellerLienRompus,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text('Liens rompus',
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                      Text(
                                                          '${snapshot.data!.length}')
                                                    ],
                                                  );
                                                } else {
                                                  return Center(
                                                      child: Container());
                                                }
                                              },
                                            ),
                                          ),
                                          //Tab(text: "Entrprise",icon: Text('19'))
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (!connected) return CheckNetworkScreen();
            return ShimmerLoading(
              isLoading: isLaoding,
              contentView: TabBarView(
                children: [
                  SizedBox(
                      height: size.height * 0.7,
                      child: FutureBuilder<List<SellerModel>>(
                        future: futureNewSeller,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: LaodingData(itemCount: 12));
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            }
                            if (snapshot.hasData) {
                              return array_actifs.length == 0
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.2),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Auccun recru actif',
                                            style: TextStyle(color: black),
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddNewSellersScreen())),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: const Text(
                                                'Commencer maintenant',
                                                style: TextStyle(color: blue),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                  : ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, i) {
                                        // print(snapshot.data![i].stars);
                                        return GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsVendeurByNiveauxHome(
                                                          sellerModel:
                                                              snapshot.data![i],
                                                          vendeur_id: snapshot
                                                              .data![i].id,
                                                          name_vendeur:
                                                              '${snapshot.data![i].firstName} ${snapshot.data![i].lastName}',
                                                        ))),
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 8, right: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                        54, 158, 158, 158),
                                                    blurRadius: 2,
                                                    offset: Offset(2, 1),
                                                  ),
                                                ],
                                              ),
                                              child: ListTile(
                                                leading: snapshot
                                                            .data![i]
                                                            .userSeller!
                                                            .picturePath ==
                                                        null
                                                    ? CircleAvatar(
                                                        backgroundImage: AssetImage(
                                                            "assets/images/user.png"),
                                                      )
                                                    : Image.network(
                                                        snapshot
                                                                .data![i]
                                                                .userSeller!
                                                                .picturePath ??
                                                            imgUserDefault,
                                                      ),
                                                title: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      '${snapshot.data![i].firstName} ${snapshot.data![i].lastName}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    )),
                                                  ],
                                                ),
                                                subtitle: Text(
                                                  FormatDateHour(
                                                      '${snapshot.data![i].createdAt}'),
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                trailing: RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '${snapshot.data![i].stars}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: blue)),
                                                      TextSpan(
                                                        text: '/5',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                            } else {
                              return Center(
                                  child: const Text(
                                'Empty data',
                                style: TextStyle(color: black),
                              ));
                            }
                          } else {
                            return Text('State: ${snapshot.connectionState}');
                          }
                        },
                      )),
                  SizedBox(
                    height: size.height * 0.7,
                    child: FutureBuilder<List<SellerModel>>(
                      future: futureSellerLienRompus,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: LaodingData(itemCount: 12));
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasData && !snapshot.hasError) {
                            return array_rompus.length == 0
                                ? Center(
                                    child: const Text(
                                    'Auccun lien rompu',
                                    style: TextStyle(color: black),
                                  ))
                                : ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsVendeurByNiveauxHome(
                                                          sellerModel:
                                                              snapshot.data![i],
                                                          vendeur_id: snapshot
                                                              .data![i].id,
                                                          name_vendeur:
                                                              '${snapshot.data![i].firstName} ${snapshot.data![i].lastName}',
                                                        ))),
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffF5F6F8),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      36, 158, 158, 158),
                                                  blurRadius: 5,
                                                  offset: Offset(1, 2),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      54, 158, 158, 158),
                                                  blurRadius: 5,
                                                  offset: Offset(2, 1),
                                                ),
                                              ],
                                            ),
                                            child: ListTile(
                                              leading: snapshot
                                                          .data![i]
                                                          .userSeller!
                                                          .picturePath ==
                                                      null
                                                  ? CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          "assets/images/user.png"),
                                                    )
                                                  : Image.network(
                                                      '${snapshot.data![i].userSeller!.picturePath}'),
                                              title: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    '${snapshot.data![i].firstName} ${snapshot.data![i].lastName}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  )),
                                                ],
                                              ),
                                              subtitle: Text(
                                                FormatDateHour(
                                                    '${snapshot.data![i].createdAt}'),
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              trailing: RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            '${snapshot.data![i].stars}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: blue)),
                                                    TextSpan(
                                                      text: '/5',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                          } else {
                            return Center(
                                child: const Text(
                              'Empty data',
                              style: TextStyle(color: black),
                            ));
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'There are no bottons to push :)',
              ),
              new Text(
                'Just turn off your internet.',
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomTabbarRecruteur(
          selectedIndex: 0,
        ),
      ),
    );
  }
}
