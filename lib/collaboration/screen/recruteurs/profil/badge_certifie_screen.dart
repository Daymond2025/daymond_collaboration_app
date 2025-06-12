import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cinetpay/cinetpay.dart';
import 'package:daymond_collaboration_app/collaboration/LoadingScreen.dart';
import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
// import 'package:collaboration/models/recruteur.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/check_network_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/parametres/ConditionUsing.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/parametres/infomation/badge%20certifier/badge_certifier.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_badge_certifie.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeCertifieScreen extends StatefulWidget {
  const BadgeCertifieScreen({Key? key}) : super(key: key);

  @override
  State<BadgeCertifieScreen> createState() => _BadgeCertifieScreenState();
}

class _BadgeCertifieScreenState extends State<BadgeCertifieScreen> {
  final user_service = UserService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final demande_badge_certifie = ServiceBadgeCertifie();
  final lieuxLivraisonController = TextEditingController();
  final phoneNumberController1 = TextEditingController();
  String? taille;

  RecruterFindModel _recruteur = RecruterFindModel();
  bool _loading = true;

  // payement badge certifié
  void setPayementBadge() async {
    final String transactionId = Random().nextInt(100000000).toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? recruterId = pref.getString('recruterId');
    // int user_id = await user_services.getUserId();
    await Get.to(CinetPayCheckout(
      titleBackgroundColor: Colors.indigoAccent,
      title: 'Guichet Daymond',
      titleStyle: TextStyle(color: Colors.white),
      configData: <String, dynamic>{
        'apikey': API_KEY,
        'site_id': SITE_ID,
        'notify_url':
            'https://v2.daymondboutique.com/api/v2/payment/cinetpay/save-transaction',
        'metadata': jsonEncode({
          "type": "certified_badge",
          "recruiter_id": recruterId,
          "phone_number": phoneNumberController1.text,
          "size": "$taille",
          "delivery_city": lieuxLivraisonController.text,
        })
      },
      paymentData: <String, dynamic>{
        'transaction_id': transactionId,
        'amount': 11500,
        'currency': 'XOF',
        'channels': 'ALL',
        'description': 'Payement de badge certifié.',
      },
      waitResponse: (data) async {
        if (mounted) {
          setState(() {
            icon = data['status'] == 'ACCEPTED'
                ? Icons.check_circle
                : Icons.mood_bad_rounded;
            color =
                data['status'] == 'ACCEPTED' ? Colors.green : Colors.redAccent;
            show = true;
          });

          if (data['status'] == 'ACCEPTED') {
            ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Bravo!",
                text:
                    "Votre demande a bien été soumise, elle est en cours de traitement.",
              ),
            );
            new Timer(const Duration(seconds: 2), () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoadingScreen(),
                  ),
                  (route) => false);
            });
          } else if (data['status'] == 'REFUSED') {
            ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Echec!",
                text: "Echec du paiement.",
              ),
            );
          }
        }
      },
      onError: (error) {
        if (mounted) {
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "Echec!",
              text: "Echec du paiement.",
            ),
          );

          setState(() async {
            icon = Icons.warning_rounded;
            color = Colors.yellowAccent;
            show = true;
            Get.back();
          });

          // print(error);
        }
      },
    ));
  }

  // get users infos
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

  @override
  void initState() {
    super.initState();
    getRecruteurInfos();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: bludeBold, size: 30),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: white,
        title: Column(
          children: [
            //Image.asset('assets/images/badge_CERTIFIER.png',width: 40,),
            Text(
              "Obtenir un badge certifier".toUpperCase(),
              style: TextStyle(color: black, fontSize: 16),
            ),
          ],
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Obtenez votre pack daymond pro pour confirmer votre badge certifié.\nContenu du pack daymond pro :  \n",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "1 Tee-shirt\n1 Badge pro\n1 Casquette\n1 Polo",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15,
                              color: blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: blue),
                                  color: blue,
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/images/kit-certifie.png",
                                      ),
                                      fit: BoxFit.cover)),
                              height: size.height * 0.5,
                              width: size.width,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.16),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Coût du badge certifié: ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            TextSpan(
                                text: '11 500 ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 15)),
                            TextSpan(
                                text: 'CFA / 1 An',
                                style: TextStyle(color: black, fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    _recruteur.entity!.stars == 1
                        ? Padding(
                            padding: EdgeInsets.only(top: size.height * 0.06),
                            child: Column(
                              children: [
                                Text("Votre compte est certifié",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: blue,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Date exp : ')}", //${FormatDateHour('${_recruteur.dateExpire}
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.1,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => Container(
                                    height: size.height * 0.8,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 3,
                                                offset: const Offset(0, 0.5),
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0),
                                            child: Center(
                                              child: Text(
                                                'Formulaire de commande',
                                                style: TextStyle(
                                                    color: black, fontSize: 23),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child:
                                                        DropdownButtonFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              labelStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(14),
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              fillColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              label: Text(
                                                                " Selectionner Votre Taille ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            validator: (value) =>
                                                                value == null
                                                                    ? "Veuillez selectionner une taille"
                                                                    : null,
                                                            value: taille,
                                                            icon: Icon(Icons
                                                                .expand_more),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                taille =
                                                                    newValue!;
                                                              });
                                                            },
                                                            items: [
                                                          DropdownMenuItem(
                                                              child: Text("M"),
                                                              value: "M"),
                                                          DropdownMenuItem(
                                                              child: Text("L"),
                                                              value: "L"),
                                                          DropdownMenuItem(
                                                              child: Text("XL"),
                                                              value: "XL"),
                                                          DropdownMenuItem(
                                                              child:
                                                                  Text("XXL"),
                                                              value: "XXL"),
                                                          DropdownMenuItem(
                                                              child:
                                                                  Text("XXXL"),
                                                              value: "XXXL"),
                                                        ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: TextFormField(
                                                      controller:
                                                          lieuxLivraisonController,
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(14),
                                                        labelStyle: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        label: Text(
                                                            'Lieux de livraison'),
                                                      ),
                                                      onChanged: (value) {},
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Ce champs est vide';
                                                        }

                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: IntlPhoneField(
                                                      controller:
                                                          phoneNumberController1,
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Contact de livraison',
                                                        labelStyle: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(14),
                                                        border:
                                                            OutlineInputBorder(),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      initialCountryCode: 'CI',
                                                      onChanged: (phone) {
                                                        // print(phone
                                                        //     .completeNumber);
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top:
                                                              size.height * 0.2,
                                                          bottom: 10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            setPayementBadge();
                                                          }
                                                        },
                                                        child: Container(
                                                          width: size.width,
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          decoration: BoxDecoration(
                                                              color: blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'PAYER',
                                                              style: TextStyle(
                                                                fontSize: (18),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: size.width,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Commander mon badge',
                                    style: TextStyle(
                                      fontSize: (14),
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    _recruteur.entity!.stars == 1
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BadgeCertifier()));
                                  },
                                  child: const Text(
                                    "Plus d'information",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConditionUsing()));
                                  },
                                  child: const Text("Conditions d'utilisation",
                                      style: TextStyle(color: Colors.grey))),
                            ],
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
