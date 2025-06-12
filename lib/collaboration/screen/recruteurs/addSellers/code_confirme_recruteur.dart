import 'dart:async';

import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/InputPhoneNumber.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';

import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/addSellers/success_add_seller.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValisationCompteVendeurScreen extends StatefulWidget {
  const ValisationCompteVendeurScreen({
    Key? key,
    required this.code_otp,
    required this.NomController,
    required this.PrenomController,
    required this.PhoneNumberController,
    required this.WhatsAppPhoneNumberController,
    required this.VilleController,
    required this.ProfessionController,
    required this.password_generate,
  }) : super(key: key);
  final code_otp;
  final NomController;
  final PrenomController;
  final PhoneNumberController;
  final WhatsAppPhoneNumberController;
  final VilleController;
  final ProfessionController;

  final password_generate;

  @override
  State<ValisationCompteVendeurScreen> createState() =>
      _ValisationCompteRecruteurScreenState();
}

class _ValisationCompteRecruteurScreenState
    extends State<ValisationCompteVendeurScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController ChangePhoneNumberController = TextEditingController();
  final service_seller = ServiceSeller();
  String currentText = "";
  bool isLoading = false;
  String text = "";
  String? Email;
  String? shar_phone_number;
  String? token;

  void VerifyPhoneNumber() async {
    ButtomSetData(context, "En cours d'envoi...");
    new Timer(const Duration(seconds: 1), () async {
      ApiResponse response = await service_seller.SendCodeVerifyVendeurRequest(
          widget.PhoneNumberController);
      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Code envoyé au ${widget.PhoneNumberController}",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: green,
        ));
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ValisationCompteVendeurScreen(
                      code_otp: null,
                      NomController: widget.NomController,
                      PrenomController: widget.PrenomController,
                      PhoneNumberController: shar_phone_number == null
                          ? widget.PhoneNumberController
                          : shar_phone_number,
                      WhatsAppPhoneNumberController:
                          widget.WhatsAppPhoneNumberController,
                      VilleController: widget.VilleController,
                      ProfessionController: widget.ProfessionController,
                      password_generate: widget.password_generate)));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            '${response.error}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  void changePhoneNumber() async {
    isLoading = true;
    ApiResponse response = await service_seller.SendCodeVerifyVendeurRequest(
        ChangePhoneNumberController.text);
    new Timer(const Duration(seconds: 1), () async {
      final prefs = await SharedPreferences.getInstance();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Numéro de téléphone mis à jour : ${ChangePhoneNumberController.text}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: green,
      ));
      setState(() {
        prefs.setString('shar_phone_number', ChangePhoneNumberController.text);
        shar_phone_number = prefs.getString('shar_phone_number');
        isLoading = false;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ValisationCompteVendeurScreen(
                    code_otp: null,
                    NomController: widget.NomController,
                    PrenomController: widget.PrenomController,
                    PhoneNumberController: shar_phone_number == null
                        ? ChangePhoneNumberController.text
                        : shar_phone_number,
                    WhatsAppPhoneNumberController:
                        widget.WhatsAppPhoneNumberController,
                    VilleController: widget.VilleController,
                    ProfessionController: widget.ProfessionController,
                    password_generate: widget.password_generate)));
      });
    });
  }

  void addSellers() async {
    final prefs = await SharedPreferences.getInstance();
    ButtomSetData(context, 'Veuillez patienter...');
    new Timer(const Duration(seconds: 1), () async {
      ApiResponse response = await service_seller.AddSellersRequest(
        widget.NomController,
        widget.PrenomController,
        shar_phone_number == null
            ? widget.PhoneNumberController
            : shar_phone_number,
        widget.WhatsAppPhoneNumberController,
        widget.VilleController,
        widget.ProfessionController,
        widget.password_generate,
        currentText,
      );
      // print([response.data, response.error, response.message]);
      if (response.error == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SuccessAddSeller(
                      firstName: widget.NomController,
                      lastName: widget.PrenomController,
                    )),
            (route) => false);
        prefs.remove('shar_phone_number');
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            '${response.error}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Confirmation du compte'.toUpperCase(),
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Center(
            child: Image.asset(
              'assets/images/clock.png',
              width: 40,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "Saisissez le code de verification qui a été envoyé  ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                  TextSpan(
                                    text: 'au ',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          '${shar_phone_number == null ? widget.PhoneNumberController : shar_phone_number}',
                                      style: TextStyle(
                                          color: primary, fontSize: 18)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //OTPFORM(textEditingController: textEditingController,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: PinCodeFields(
                      length: 5,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      onComplete: (v) {
                        // Your logic with pin code
                        addSellers();
                      },
                      onChange: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    VerifyPhoneNumber();
                  },
                  child: Text(
                    'Renvoyer le code',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          contentPadding: const EdgeInsets.only(top: 10.0),
                          title: Column(
                            children: [
                              Text(
                                "Numéo de confirmation incorrect entrer le bon numéro ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              InputPhoneNumber(
                                PhoneNumberController:
                                    ChangePhoneNumberController,
                                Label: "Entrer le bon numéro",
                              )
                            ],
                          ),
                          content: Container(
                            width: 500.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    changePhoneNumber();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    decoration: const BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0)),
                                    ),
                                    child: isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: white,
                                            strokeWidth: 3.0,
                                          ))
                                        : Text(
                                            "Valider",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Text(
                  'Numéro incorrect ? ',
                  style: TextStyle(fontSize: 16),
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: 50,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: primary, borderRadius: BorderRadius.circular(6)),
              child: GestureDetector(
                onTap: currentText.length == 5
                    ? () {
                        addSellers();
                      }
                    : null,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Confirmer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
