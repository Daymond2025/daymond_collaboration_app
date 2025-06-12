import 'dart:async';

import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/screen/auth/reset_password_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class RessetPasswordCodeVerification extends StatefulWidget {
  const RessetPasswordCodeVerification({super.key, required this.email});
  final email;
  @override
  State<RessetPasswordCodeVerification> createState() =>
      _RessetPasswordCodeVerificationState();
}

class _RessetPasswordCodeVerificationState
    extends State<RessetPasswordCodeVerification> {
  final _formKey = GlobalKey<FormState>();
  final user_service = UserService();
  String currentText = "";
  bool _isLoading = false;
  String text = "";
  void SendVerifyCode() async {
    ButtomSetData(context, 'Veuillez patienter ............');
    new Timer(const Duration(seconds: 1), () async {
      ApiResponse response = await user_service.SendRessetCodeVerify(
          '${widget.email}', '${currentText}');

      print('STATUT REQUETE ${user_service.StatusCode}');
      if (response.error == null && user_service.StatusCode == 200) {
        Navigator.pop(context);
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RessetPasswordScreen(
                      email: '${widget.email}',
                      code_verify: '${currentText}')));
        });
      } else if (user_service.StatusCode == 300) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "auccun compte correspond a ce code",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Vérifier code de rénitialisation'.toUpperCase(),
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
                            text: '${widget.email}',
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
                  animation: Animations.fade,
                  activeBorderColor: primary,
                  length: 5,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onComplete: (v) {
                    // Your logic with pin code
                    SendVerifyCode();
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
                onTap: () {},
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
