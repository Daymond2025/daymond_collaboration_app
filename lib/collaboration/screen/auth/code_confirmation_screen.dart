import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:daymond_collaboration_app/collaboration/screen/home_recruteurs_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_seller.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  const ConfirmationCodeScreen({
    Key? key,
    required this.code_otp,
    required this.NomController,
    required this.PrenomController,
    required this.VilleController,
    required this.PhoneNumberController,
    required this.EmailController,
    required this.Controllerpassword,
    required this.jobController,
  }) : super(key: key);
  final code_otp;
  final NomController;
  final PrenomController;
  final VilleController;
  final PhoneNumberController;
  final EmailController;
  final Controllerpassword;
  final jobController;
  @override
  State<ConfirmationCodeScreen> createState() =>
      _ValisationCompteRecruteurScreenState();
}

class _ValisationCompteRecruteurScreenState
    extends State<ConfirmationCodeScreen> {
  TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final user_service = UserService();
  final service_seller = ServiceSeller();
  String currentText = "";
  bool _isLoading = false;
  String text = "";

  void SendCodeVerifyRecruteur() async {
    ButtomSetData(context, 'Veuillez patienter...');
    new Timer(const Duration(seconds: 1), () async {
      ApiResponse response =
          await service_seller.SendCodeVerifyRecruteurRequest(
              widget.EmailController);
      if (response.error == null) {
        Navigator.pop(context);
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.info,
                title: "Succès !",
                text: "Code envoyé au ${widget.EmailController}"));
        new Timer(const Duration(seconds: 1), () async {
          Navigator.pop(context);
        });
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

  void addRecruteur() async {
    ButtomSetData(context, 'Veuillez patienter ...');
    new Timer(const Duration(seconds: 1), () async {
      ApiResponse response = await user_service.AddRecruteurRequest(
          widget.NomController,
          widget.PrenomController,
          widget.VilleController.toString(),
          widget.PhoneNumberController,
          widget.jobController,
          widget.EmailController,
          widget.Controllerpassword,
          currentText);
      if (response.error == null) {
        _saveAndRedirectHome(response.data as RecruterLoginModel);
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            '${response.error} ou veuillez bien renseigner vos informations',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  void _saveAndRedirectHome(RecruterLoginModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setInt('userId', user.user!.id ?? 0);
    await pref.setString('token', user.token ?? '');
    await pref.setString('role_as', user.option!.role ?? '');

    Navigator.pop(context);
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Succès",
            text: "Votre compte a été créé avec succès"));
    new Timer(const Duration(seconds: 1), () async {
      Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeRecruteurScreen()),
          (route) => false);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Confirmation du compte'.toUpperCase(),
          style: TextStyle(
              color: primary, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Center(
            child: Image.asset(
              'assets/images/clock.png',
              width: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'Saisissez le code de verification qui vous a été envoyé par: ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        TextSpan(
                            text: '${widget.EmailController}',
                            style: TextStyle(color: primary, fontSize: 16))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              //OTPFORM(textEditingController: textEditingController,),
              Form(
                key: _formKey,
                child: PinCodeFields(
                  activeBorderColor: primary,
                  length: 5,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onComplete: (v) {
                    // Your logic with pin code
                    addRecruteur();
                  },
                  onChange: (value) {
                    setState(() {
                      currentText = value;
                      // print(currentText);
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  SendCodeVerifyRecruteur();
                },
                child: Text(
                  'Renvoyer le code',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:<Widget> [
              InkWell(
                onTap: (){},
                child: Text('Consulter ma boite mail',style: TextStyle(fontSize: 18)),
              )
            ],
          ),*/

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xff880068), primary],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Confirmer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
