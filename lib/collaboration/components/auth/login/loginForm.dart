// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable, file_names, use_build_context_synchronously

import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/DefaultButton.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/CostumInput.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/InputPassword.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';

import 'package:daymond_collaboration_app/collaboration/screen/auth/forgot_password_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/auth/regsiter_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/home_recruteurs_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    Key? key,
  }) : super(
          key: key,
        );
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final user_service = UserService();

  TextEditingController PasswordControler = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );
  bool visibl = true;
  bool remember = false;
  bool isloading = false;

  void loginPressUser() async {
    print("[LOGIN] Début loginPressUser()");

    ApiResponse response = await user_service.Login(
      EmailController.text.trim(),
      PasswordControler.text.trim(),
    );

    print("[LOGIN] Réponse reçue");

    if (!mounted) return;

    if (response.error == null) {
      print("[LOGIN] Connexion réussie");
      _saveAndRedirectHome(response.data as RecruterLoginModel);
    } else {
      print("[LOGIN] Erreur : ${response.error}");

      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Oups !",
          text: "Coordonnées incorrectes",
        ),
      );
    }
  }


  void _saveAndRedirectHome(RecruterLoginModel recruter) async {
    print("[SAVE] Début _saveAndRedirectHome");

    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('userId', recruter.user?.id ?? 0);
    await pref.setString('token', recruter.token ?? '');
    await pref.setString('role_as', recruter.option?.role ?? '');

    if (!mounted) return;

    print("[SAVE] Redirection vers HomeRecruteurScreen...");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeRecruteurScreen()),
      (route) => false,
    );
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var textInputType =
        const TextInputType.numberWithOptions(signed: true, decimal: true);
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  CostumInput(
                      Label: "Entrer votre Email",
                      Controller: EmailController,
                      Icon: Icon(
                        Icons.email,
                        color: primary,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  InputPassword(
                    PasswordControler: PasswordControler,
                    Label: 'Tapez votre mot de passe',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                child: Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: remember,
                                  activeColor: blue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      remember = !remember;
                                    });
                                  },
                                ),
                              ),
                              const Text("Se souvenir de moi"),
                            ],
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()));
                            },
                            // ignore: prefer_const_constructors
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: const Text(
                                "Mot de passe oublié",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: primary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.13,
                  ),
                  DefaultButton(
                    text: "Connexion",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        loginPressUser();
                      }
                    },
                    // ignore: unrelated_type_equality_checks
                    //widget.role=='ambassadeur'? Navigator.pushNamed(context, "CodeConfirmPage"):widget.role=='recruteur'?Navigator.pushNamed(context, "CodeConfirmPage"):Navigator.pushNamed(context, "CodeConfirmPage");
                    // if (_formKey.currentState!.validate()) {

                    // }
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen(
                                    cities: [],
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                      child: Text(
                        'Créer un compte',
                        style: TextStyle(color: primary),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
