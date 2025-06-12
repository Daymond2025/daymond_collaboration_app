import 'dart:async';
import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/seller_model.dart';
import 'package:daymond_collaboration_app/collaboration/models/statistique_model.dart';
import 'package:daymond_collaboration_app/collaboration/screen/home_recruteurs_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/produits_vendeurs_recruteurs_home.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_seller.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsVendeurByNiveauxHome extends StatefulWidget {
  const DetailsVendeurByNiveauxHome({
    Key? key,
    required this.vendeur_id,
    this.name_vendeur,
    this.sellerStats,
    this.sellerModel,
  }) : super(key: key);
  final vendeur_id;
  final name_vendeur;
  final SellerStats? sellerStats;
  final SellerModel? sellerModel;
  @override
  State<DetailsVendeurByNiveauxHome> createState() =>
      _DetailsVendeurByNiveauxHomeState();
}

class _DetailsVendeurByNiveauxHomeState
    extends State<DetailsVendeurByNiveauxHome> {
  SellerStats? _vendeur = SellerStats();
  SellerModel _seller = SellerModel();
  List<dynamic> array_order_users = [];
  final seller = ServiceSeller();
  final user_service = UserService();
  bool _loading = true;

  Future getSellerInfo() async {
    ApiResponse responseCommand = await seller.CommandesBySeller(
        widget.sellerStats == null
            ? widget.vendeur_id.toString()
            : widget.sellerStats!.id.toString());
    print("==============Commandes vendeur ==============");

    if (responseCommand.error == null) {
      setState(() {
        _vendeur = widget.sellerStats ?? null;
        array_order_users = responseCommand.data as List<dynamic>;
        // print(array_order_users[0]['order']);
        _loading = false;
      });
    } else if (widget.sellerStats == null) {
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
      print('error');
    }
  }

  whatsapp() async {
    var contact = _vendeur == null
        ? widget.sellerModel!.userSeller!.phoneNumber
        : "${_vendeur!.user!.phoneNumber}";
    var androidUrl = "whatsapp://send?phone=$contact&text=";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('')}";
    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp n'est pas installé sur l'appareil"),
        ),
      );
    }
  }

  void rompreLien(BuildContext context) async {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            denyButtonText: 'Non',
            denyButtonColor: blue,
            confirmButtonText: 'Oui',
            confirmButtonColor: Colors.red,
            title: "Attention !!!",
            text:
                "Voulez-vous vraiment rompre le lien avec ${widget.name_vendeur}",
            onConfirm: () async {
              Navigator.pop(context);
              ButtomSetData(context, 'Rupture en cours ...');
              new Timer(const Duration(seconds: 1), () async {
                ApiResponse response = await seller.rompreLienRequest(
                    _vendeur == null
                        ? '${widget.sellerModel!.id}'
                        : '${_vendeur!.id}');
                // print(response.data);
                if (response.error == null) {
                  new Timer(const Duration(seconds: 1), () async {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomeRecruteurScreen()));
                  });
                  ArtSweetAlert.show(
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.success,
                          title: "Succès!",
                          text: "${response.data}"));
                } else if (response.error == unauthorized) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const OnboardingScreen()),
                      (route) => false);
                  user_service.logout();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Veuillez vous conntecter. '),
                    ),
                  );
                } else {
                  Navigator.pop(context);
                  ArtSweetAlert.show(
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.danger,
                          title: "Oups !",
                          text: "${response.error}"));
                }
              });
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSellerInfo();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.sellerModel!.stars);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text('Recrue', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              color: Colors.white,
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Text(
                        'Epingler',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        user_service.getRole().then((value) => {
                              rompreLien(context),
                            });
                      },
                      child: Text('Rompre le lien',
                          style:
                              TextStyle(fontSize: 20, color: Colors.black54)),
                    ),
                  ])
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 250,
                        // ignore: prefer_const_literals_to_create_immutables
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                              ),
                            ]),
                      ),
                      Container(
                        height: size.width < 350 ? 80 : 110,
                        decoration: BoxDecoration(
                            color: Color(0xff2546F3),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                      ),
                      Positioned(
                        top: 50,
                        left: size.width < 350 ? 20 : 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width < 350 ? 80 : 80,
                              height: size.width < 350 ? 80 : 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: widget.sellerModel!.userSeller!
                                                      .picturePath ==
                                                  null ||
                                              _seller.userSeller!.picturePath ==
                                                  null
                                          ? AssetImage('assets/images/user.png')
                                          : NetworkImage(_vendeur == null
                                              ? '${widget.sellerModel!.userSeller!.picturePath}'
                                              : _vendeur!.user!.picturePath ??
                                                  imgUserDefault),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(color: Colors.white, width: 4),
                                  borderRadius: BorderRadius.circular(60)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.06),
                                  child: Text(
                                    _vendeur == null
                                        ? '${widget.sellerModel!.firstName} ${widget.sellerModel!.lastName}'
                                        : '${_vendeur!.firstName} ${_vendeur!.lastName}',
                                    style: TextStyle(
                                        fontSize: size.width < 350 ? 15 : 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 12,
                                      left: size.width * 0.06),
                                  child: Text(
                                    "${FormatDateHour(_vendeur == null ? '${widget.sellerModel!.createdAt}' : '${_vendeur!.createdAt}')}",
                                    style: TextStyle(
                                        fontSize: size.width < 350 ? 12 : 13,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: size.width < 350 ? 90 : 130,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/ci.png',
                                    width: size.width < 350 ? 25 : 25,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "CI, ",
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    "ABIDJAN",
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Container(
                                      child: Text(
                                    'Téléphone : ',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  )),
                                  Container(
                                      child: Text(
                                    _vendeur == null
                                        ? '${widget.sellerModel!.userSeller!.phoneNumber}'
                                        : '+${_vendeur!.user!.phoneNumber}',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              _vendeur == null
                                  ? GestureDetector(
                                      onTap: () {
                                        whatsapp();
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 0.0, top: 0),
                                        child: Row(
                                          children: [
                                            Container(
                                                child: Text(
                                              'Whatsapp : ',
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            )),
                                            Text(
                                              _vendeur == null
                                                  ? '${widget.sellerModel!.userSeller!.phoneNumber}'
                                                  : "+${_vendeur!.user!.phoneNumber}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : _vendeur!.user!.phoneNumber != null
                                      ? GestureDetector(
                                          onTap: () {
                                            whatsapp();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.0, top: 0),
                                            child: Row(
                                              children: [
                                                Container(
                                                    child: Text(
                                                  'Whatsapp : ',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                )),
                                                Text(
                                                  _vendeur == null
                                                      ? '${widget.sellerModel!.userSeller!.phoneNumber}'
                                                      : "+${_vendeur!.user!.phoneNumber}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.green),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'Niveau',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Text(
                                _vendeur == null
                                    ? '${widget.sellerModel!.stars} / 5'
                                    : '${_vendeur!.stars} / 5',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SingleChildScrollView(
                        child: array_order_users.length == 0
                            ? Center(
                                child: Container(
                                  child: Text(
                                    'Aucune Vente Effectué',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: array_order_users.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return array_order_users[index]['order'] ==
                                          null
                                      ? Container()
                                      : GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProduitsVendeursRecruteursHome(
                                                          sellerModel: widget
                                                              .sellerModel,
                                                          id: widget.vendeur_id,
                                                          nom_produit:
                                                              '${array_order_users[index]['order']['items'][0]['product']['name']}',
                                                          sous_titre:
                                                              '${array_order_users[index]['order']['items'][0]['product']['sub_title']}',
                                                          image_produit:
                                                              '${array_order_users[index]['order']['items'][0]['product']['images'][0]}',
                                                          prix_total:
                                                              '${array_order_users[index]['order']['items'][0]['price']}',
                                                          gain:
                                                              '${array_order_users[index]['amount']}',
                                                          lieux_vente:
                                                              '${array_order_users[index]['order']['delivery']['city']['name']}',
                                                          date_vente:
                                                              '${FormatDateHour('${array_order_users[index]['order']['created_at']}')}',
                                                          prix_vente:
                                                              '${array_order_users[index]['order']['items'][0]['product']['price']['price']}',
                                                          bonus:
                                                              '${array_order_users[index]['amount']}',
                                                        ))),
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromARGB(
                                                            255, 177, 175, 175),
                                                        offset: Offset(
                                                          .5,
                                                          .5,
                                                        ),
                                                        blurRadius: 3,
                                                      ), //BoxShadow
                                                      //BoxShadow
                                                    ]),
                                                child: ListTile(
                                                  leading: Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                '${array_order_users[index]['order']['items'][0]['product']['images'][0]}'),
                                                            // '${transactionsModel.order!.items![0].product!.images![0]}'),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  title: Text(
                                                      '${array_order_users[index]['order']['items'][0]['product']['name']}'),
                                                  subtitle: Text(
                                                      '${FormatDateHour('${array_order_users[index]['created_at']}')}'),
                                                  trailing: Text(
                                                    '${array_order_users[index]['amount']} Fcfa',
                                                    style: TextStyle(
                                                      color: blue,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                }),
                      )
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: _loading
            ? Center(
                child: Container(),
              )
            : Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    // RichText(
                    //   text: TextSpan(
                    //     children: <TextSpan>[
                    //       TextSpan(
                    //           text:
                    //               'Il ne vous reste plus que ${int.parse('100') - int.parse(_vendeur == null ? '${widget.sellerModel!.stars}' : '${_vendeur!.stars}')} niveaux pour gagner \n un bonus de',
                    //           style: TextStyle(color: black, fontSize: 14)),
                    //       TextSpan(
                    //           text: ' 5000 FCA',
                    //           style: TextStyle(color: blue, fontSize: 14)),
                    //       TextSpan(
                    //           text: ' gratuit offert par daymond',
                    //           style: TextStyle(color: black, fontSize: 14)),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
}
