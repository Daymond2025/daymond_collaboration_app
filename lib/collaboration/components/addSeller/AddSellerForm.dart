// ignore_for_file: non_constant_identifier_names, file_names, unused_local_variable
import 'dart:async';
import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/CostumInput.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/InputPhoneNumber.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';

import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/addSellers/code_confirme_recruteur.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_seller.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddSellerForm extends StatefulWidget {
  final List<CityModel> cities;
  const AddSellerForm({Key? key, required this.cities}) : super(key: key);
  @override
  State<AddSellerForm> createState() => _AddSellerFormState();
}

class _AddSellerFormState extends State<AddSellerForm> {
  final _formKey = GlobalKey<FormState>();
  CityModel? selectedCity;
  final service_seller = ServiceSeller();
  TextEditingController NomController = TextEditingController();
  TextEditingController PrenomController = TextEditingController();
  TextEditingController ProfessionController = TextEditingController();
  TextEditingController countryValue = TextEditingController();
  TextEditingController VilleController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController WhatsAppPhoneNumberController = TextEditingController();
  String code_otp = '01234';
  bool remember = false;
  String typeEnginsselected = "Côte d'Ivoire";
  void VerifyPhoneNumber() async {
    print('Numéro WhatsApp envoyé au backend : ${WhatsAppPhoneNumberController.text}');

    ApiResponse response = await service_seller.SendCodeVerifyVendeurRequest(
      PhoneNumberController.text,
    );

    if (!mounted) return;

    if (response.error == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ValisationCompteVendeurScreen(
            code_otp: null,
            NomController: NomController.text.trim(),
            PrenomController: PrenomController.text.trim(),
            PhoneNumberController: PhoneNumberController.text.trim(),
            WhatsAppPhoneNumberController: WhatsAppPhoneNumberController.text.trim(),
            VilleController: selectedCity!.id.toString(),
            ProfessionController: ProfessionController.text.trim(),
            password_generate: service_seller.generatePassword(),
          ),
        ),
      );
    } else if (response.error == unauthorized) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Connectez-vous',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));

      await user_services.logout();

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${response.error}',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
    }
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
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
                          padding: const EdgeInsets.only(
                            right: 5,
                          ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: CostumInput(
                        Controller: ProfessionController,
                        Label: "Profession",
                        Icon: Icon(Icons.person),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 50,
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
                              child: CountryCodePicker(
                                onChanged: print,
                                initialSelection: 'CI',
                                favorite: ['+225', 'FR'],
                                showCountryOnly: true,
                                showOnlyCountryWhenClosed: true,
                                alignLeft: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8), // Espace fixe, plus stable que un `Padding.only`
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 50,
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
                                value: selectedCity,
                                isExpanded: true, // 🔥 le plus important ici !
                                hint: const Text('Choisissez une Ville'),
                                items: widget.cities.map((CityModel city) {
                                  return DropdownMenuItem<CityModel>(
                                    value: city,
                                    child: Text(
                                      city.name!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (CityModel? newValue) {
                                  setState(() {
                                    selectedCity = newValue;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InputPhoneNumber(
                        PhoneNumberController: PhoneNumberController,
                        Label: "Numéro de téléphone",
                      ),
                    ),
                    InputPhoneNumber(
                      PhoneNumberController: WhatsAppPhoneNumberController,
                      Label: "Numéro whatsApp",
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 20),
                        child: FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: green,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              VerifyPhoneNumber();
                            }
                          },
                          child: Container(
                            width: size.width,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Inscription',
                                style: TextStyle(
                                  fontSize: (18),
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
