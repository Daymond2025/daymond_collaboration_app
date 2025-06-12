import 'dart:async';

import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/DefaultButton.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/InputPassword.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/screen/auth/login_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';

class RessetPasswordScreen extends StatefulWidget {
  const RessetPasswordScreen(
      {super.key, required this.email, required this.code_verify});
  final email;
  final code_verify;
  @override
  State<RessetPasswordScreen> createState() => _RessetPasswordScreenState();
}

class _RessetPasswordScreenState extends State<RessetPasswordScreen> {
  final user_service = UserService();
  final _formKey = GlobalKey<FormState>();
  final PasswordControler1 = TextEditingController();
  final PasswordControler2 = TextEditingController();

  void UPdatePassword() async {
    if (PasswordControler1.text == PasswordControler2.text) {
      ButtomSetData(context, 'Veuillez patienter ...');
      new Timer(const Duration(seconds: 1), () async {
        ApiResponse response = await user_service.UpdatePasswordReequest(
            '${widget.email}',
            '${widget.code_verify}',
            '${PasswordControler1.text}');
        print("STATUT CODE ${user_service.StatusCode}");
        if (response.error == null && user_service.StatusCode == 200) {
          Navigator.pop(context);
          setState(() {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          });
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              '${response.error}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Désolé les mots de passe doivent correspondre',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        //iconTheme: const IconThemeData(color: primary),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.18),
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.16,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/daymond_logo.png'),
                          fit: BoxFit.contain)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                  child: Text(
                    'Créer un nouveau mot de passe'.toUpperCase(),
                    style:
                        TextStyle(color: primary, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 50, right: 10, left: 10, bottom: 10),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      children: [
                        InputPassword(
                          PasswordControler: PasswordControler1,
                          Label: 'Tapez votre mot de passe',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputPassword(
                          PasswordControler: PasswordControler2,
                          Label: 'Tapez à nouveau votre mot de passe',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: DefaultButton(
            text: "Envoyer",
            press: () {
              if (_formKey.currentState!.validate()) {
                UPdatePassword();
              }
            },
          ),
        ),
      ),
    );
  }
}
