// ignore_for_file: file_names, unused_import, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, override_on_non_overriding_member
import 'dart:async';

import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/DefaultButton.dart';
import 'package:daymond_collaboration_app/collaboration/components/TextFIeldContainer.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/CostumInput.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/CountryPicker.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/InputEmail.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/InputPassword.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/InputPhoneNumber.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';

import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:daymond_collaboration_app/collaboration/screen/auth/code_confirmation_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/auth/login_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_seller.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final List<CityModel> cities;
  const RegisterForm({Key? key, required this.cities}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final user_service = UserService();
  final service_seller = ServiceSeller();
  bool isloading = false;
  String error = '';

  final _formKey = GlobalKey<FormState>();
  TextEditingController NomController = TextEditingController();
  TextEditingController PrenomController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController VilleController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordControler = TextEditingController();
  TextEditingController RepeatPasswordControler = TextEditingController();

  bool remember = false;

  CityModel? selectedCity;

  void SendCodeVerifyRecruteur() async {
    if (PasswordControler.text.trim() == RepeatPasswordControler.text.trim()) {
      ButtomSetData(context, 'Veuillez patienter...');
      new Timer(const Duration(seconds: 1), () async {
        ApiResponse response =
            await service_seller.SendCodeVerifyRecruteurRequest(
                EmailController.text.trim());
        if (response.error == null) {
          new Timer(const Duration(seconds: 1), () async {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmationCodeScreen(
                            code_otp: null,
                            NomController: NomController.text.trim(),
                            PrenomController: PrenomController.text.trim(),
                            VilleController: selectedCity!.id,
                            PhoneNumberController:
                                PhoneNumberController.text.trim(),
                            EmailController: EmailController.text.trim(),
                            Controllerpassword: PasswordControler.text.trim(),
                            jobController: jobController.text.trim(),
                          )));
            });
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
    print("les citées ${widget.cities}");
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: CostumInput(
                            Controller: NomController,
                            Label: "Nom",
                            Icon: Icon(Icons.person)),
                      )),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: CostumInput(
                          Controller: PrenomController,
                          Label: "Prénoms",
                          Icon: Icon(Icons.person),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CostumInput(
                              Controller: jobController,
                              Label: "Profession",
                              Icon: Icon(Icons.shopping_bag),
                            )),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      offset: const Offset(0, 0.5),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                                child: DropdownButtonFormField<CityModel>(
                                    onTap: () {
                                      print('select tapé');
                                    },
                                    value: selectedCity,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    hint: const Text(
                                      'Choisissez une Ville',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    items: widget.cities.map((CityModel city) {
                                      return DropdownMenuItem<CityModel>(
                                        value: city,
                                        child: Text(city.name!,
                                            style: TextStyle(fontSize: 13)),
                                      );
                                    }).toList(),
                                    onChanged: (CityModel? newValue) {
                                      setState(() {
                                        selectedCity = newValue;
                                      });
                                    }),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: InputPhoneNumber(
                      PhoneNumberController: PhoneNumberController,
                      Label: 'Numéro de téléphone',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: InputEmail(
                      EmailController: EmailController,
                      Label: 'Entrer votre Email',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: InputPassword(
                      PasswordControler: PasswordControler,
                      Label: ' Mot de passe',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: InputPassword(
                      PasswordControler: RepeatPasswordControler,
                      Label: 'Entrez à nouneau le mot de passe',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: DefaultButton(
                        text: "Enregister",
                        couleur: remember ? blue : grey,
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            SendCodeVerifyRecruteur();
                          }
                        }),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Text(
                        "J'ai un compte",
                        style: TextStyle(color: primary),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
