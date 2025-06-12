import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/components/skeletonLaoding.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/screen/portefeuilles/portefeuille_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/transaction_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ClickNumeroRetraitScreen extends StatefulWidget {
  const ClickNumeroRetraitScreen(
      {super.key,
      required this.image,
      required this.operateur,
      required this.numero});
  final String image;
  final String operateur;
  final String numero;
  @override
  State<ClickNumeroRetraitScreen> createState() =>
      _ClickNumeroRetraitScreenState();
}

class _ClickNumeroRetraitScreenState extends State<ClickNumeroRetraitScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _all = false;
  bool isLaoding = true;
  String? id_portefeuille;
  final montantController = TextEditingController();
  final contact = TransactionService();
  Future getBalanceUser() async {
    final token = await user_services.getToken();
    final response =
        await http.get(Uri.parse('$apiUrl/getBalanceCompteByUser'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200) {
      setState(() {
        final arraySommeWallet = json.decode(response.body)['solde_compte'];
        somme = arraySommeWallet['somme'].toString();
        id_portefeuille = arraySommeWallet['id'].toString();
        // print(id_portefeuille);
        isLaoding = false;
      });
    }
  }

  ///////////////// set paiement //////////////
  void setDemandeRetrait() async {
    if (somme == '0') {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning,
            title: "Oppp !!!",
            text: "Désolé vous ne pouvez pas faire de retrait actuellement",
            //onConfirm: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PortefeuilleScreen())),
          ));
    } else {
      ButtomSetData(context, 'Transaction en cours ...');
      new Timer(const Duration(seconds: 1), () async {
        ApiResponse response = await contact.demandeRetraits(
            _all
                ? montantController.text = '${somme}'
                : montantController.text.trim(),
            widget.numero,
            widget.operateur);
        Navigator.pop(context);
        if (response.error == null) {
          Navigator.pop(context);
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Succès!",
                text: "Votre demande de retrait est en cours de traitement ...",
                onConfirm: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PortefeuilleScreen())),
              ));
          new Timer(const Duration(seconds: 1), () async {
            setState(() {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PortefeuilleScreen()));
            });
          });
        } else if (response.error == null) {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.info,
                title: "Oppp !!!",
                text: "Désolé votre solde est insuffisant",
                //onConfirm: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PortefeuilleScreen())),
              ));
        } else {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "OOpp !",
                  text: "${response.error}"));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBalanceUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShimmerLoading(
        isLoading: isLaoding,
        contentView: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(1, 22, 103, 10),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/portefeuille.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 25,
                            child: Text(
                              'SOLDES ACTUEL : ${somme} CFA',
                              style: TextStyle(
                                color: white,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //back
                  Positioned(
                    top: 30,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1.7),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      widget.image,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.operateur} money',
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    widget.numero,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20,
                                color: _all == true ? black : black),
                            keyboardType: TextInputType.number,
                            enabled: _all == true ? false : true,
                            controller: _all
                                ? TextEditingController(text: '${somme}')
                                : montantController,
                            decoration: const InputDecoration(
                              suffix: Text(
                                'CFA',
                                style: TextStyle(fontSize: 20),
                              ),
                              filled: true,
                              fillColor: white,
                              labelText: 'Montant à rétirer',
                              hintText: '10 000',
                              labelStyle: TextStyle(color: blue),
                              focusColor: blue,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                borderSide: BorderSide(
                                  color: blue,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez entrer un montant';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Retirer gratuitement et à tout moment',
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 13),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Tout rétirer',
                                    ),
                                    Checkbox(
                                      activeColor: blue,
                                      checkColor: white,
                                      value: _all,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _all = value!;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      bottomSheet: isLaoding
          ? Container()
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setDemandeRetrait();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "ENVOYEZ LA DEMANDE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )),
              ),
            ),
    );
  }
}
