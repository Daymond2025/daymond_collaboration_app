import 'dart:async';
import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:daymond_collaboration_app/collaboration/LoadingScreen.dart';
import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/check_network_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/CostumInput.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/InputEmail.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/InputPhoneNumber.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class UpdateRecruteurProfil extends StatefulWidget {
  const UpdateRecruteurProfil({super.key});

  @override
  State<UpdateRecruteurProfil> createState() => _UpdateRecruteurProfilState();
}

class _UpdateRecruteurProfilState extends State<UpdateRecruteurProfil> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController NomController = TextEditingController();
  TextEditingController PrenomController = TextEditingController();
  TextEditingController JobController = TextEditingController();
  TextEditingController countryValue = TextEditingController();
  TextEditingController VilleController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  File? photo_profile;

  RecruterFindModel _recruteur = RecruterFindModel();
  bool _loading = true;

  Future getRecruteurInfos() async {
    ApiResponse response = await user_services.getUserDetail();

    if (response.error == null) {
      setState(() {
        _recruteur = response.data as RecruterFindModel;
        NomController.text = "${_recruteur.entity!.firstName} ";
        PrenomController.text = _recruteur.entity!.firstName.toString();
        JobController.text = _recruteur.entity!.job.toString();
        VilleController.text = _recruteur.entity!.city!.name.toString();
        PhoneNumberController.text = _recruteur.phoneNumber.toString();
        EmailController.text = _recruteur.email.toString();

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

  // upate user picture
  _getImages(int cunt) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Navigator.pop(context);
      setState(() {
        if (cunt == 1) {
          // _loading = true;
          photo_profile = File(pickedFile.path);
          // ButtomSetData(context, 'Laoding ...');
        }
      });
      // ApiResponse response =
      //     await user_services.updateUserPicture('${photo_profile?.path}');
      // if (response.error == null) {
      //   getRecruteurInfos();
      //   ArtSweetAlert.show(
      //     context: context,
      //     artDialogArgs: ArtDialogArgs(
      //         type: ArtSweetAlertType.success,
      //         title: "Succès.",
      //         text: response.data.toString()),
      //   );
      // } else if (response.error == unauthorized) {
      //   setState(() {
      //     _loading = false;
      //   });
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      //       (route) => false);
      //   user_services.logout();

      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Veuillez vous conntecter. '),
      //     ),
      //   );
      // } else {
      //   setState(() {
      //     _loading = false;
      //   });
      //   // ignore: use_build_context_synchronously
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Echec à la connexion. '),
      //     ),
      //   );

      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => const CheckNetworkScreen()),
      //       (route) => false);
      // }
    }
  }

  _getImagesGallerie(int cunt) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Navigator.pop(context);
      setState(() {
        if (cunt == 1) {
          // _loading = true;
          photo_profile = File(pickedFile.path);
          // ButtomSetData(context, 'Laoding ...');
        }
      });
      // ApiResponse response =
      //     await user_services.updateUserPicture('${photo_profile?.path}');
      // if (response.error == null) {
      //   getRecruteurInfos();
      //   ArtSweetAlert.show(
      //     context: context,
      //     artDialogArgs: ArtDialogArgs(
      //         type: ArtSweetAlertType.success,
      //         title: "Succès.",
      //         text: response.data.toString()),
      //   );
      // } else if (response.error == unauthorized) {
      //   setState(() {
      //     _loading = false;
      //   });
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      //       (route) => false);
      //   user_services.logout();

      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Veuillez vous conntecter. '),
      //     ),
      //   );
      // } else {
      //   setState(() {
      //     _loading = false;
      //   });
      //   // ignore: use_build_context_synchronously
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Echec à la connexion. '),
      //     ),
      //   );

      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => const CheckNetworkScreen()),
      //       (route) => false);
      // }
    }
  }

  ///////update user data
  Future UpdateUserData() async {
    ButtomSetData(context, 'Veuillez patienter ...');
    setState(() {
      _loading = true;
    });
    new Timer(const Duration(seconds: 1), () async {
      ApiResponse response = await user_services.updateUserAccount(
          NomController.text,
          PrenomController.text,
          JobController.text,
          VilleController.text == 'Abidjan' ? '1' : '0',
          PhoneNumberController.text,
          EmailController.text.trim(),
          photo_profile!);
      if (response.error == null) {
        Navigator.pop(context);
        getRecruteurInfos();
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Succès !",
                text: "Profil mise à jour"));

        new Timer(const Duration(seconds: 1), () async {
          setState(() {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoadingScreen()));
          });
        });
      } else if (response.error == unauthorized) {
        setState(() {
          _loading = false;
        });
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
        setState(() {
          _loading = false;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error.toString()),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecruteurInfos();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        //elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Modifier mes informations",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Container(
                      child: Column(children: [
                        Container(
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: photo_profile == null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: _recruteur.picture == null
                                                  ? AssetImage(
                                                      'assets/images/user.png')
                                                  : NetworkImage(_recruteur
                                                              .picture !=
                                                          null
                                                      ? '${_recruteur.picture}'
                                                      : imgUserDefault),
                                            )
                                          : null),
                                  child: photo_profile != null &&
                                          _recruteur.picture == null
                                      ? Image.file(
                                          photo_profile!,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        )
                                      : null,
                                ),
                                Positioned(
                                  top: 60,
                                  right: 1,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: blue),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          spreadRadius: 0.5,
                                          blurRadius: 0.5,
                                          offset: Offset(0.5, 0.5),
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext bc) {
                                              return SafeArea(
                                                child: Container(
                                                  child: Wrap(
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: Icon(
                                                            Icons.photo_camera),
                                                        title: Text('Camera'),
                                                        onTap: () {
                                                          _getImages(1);
                                                        },
                                                      ),
                                                      ListTile(
                                                          leading: Icon(Icons
                                                              .photo_library),
                                                          title: Text(
                                                              'Gallérie photo'),
                                                          onTap: () {
                                                            _getImagesGallerie(
                                                                1);
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: blue,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text('Ajouter une photo de profil'),
                          ),
                        )
                      ]),
                    ),
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
                                      Label: "${_recruteur.entity!.firstName}",
                                      Icon: Icon(Icons.person)),
                                )),
                                Flexible(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: CostumInput(
                                    Controller: PrenomController,
                                    Label: "${_recruteur.entity!.lastName}",
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
                                    flex: 02,
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
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        initialSelection: 'CI',
                                        favorite: ['+225', 'FR'],
                                        // optional. Shows only country name and flag
                                        showCountryOnly: true,
                                        // optional. Shows only country name and flag when popup is closed.
                                        showOnlyCountryWhenClosed: true,
                                        // optional. aligns the flag and the Text left
                                        alignLeft: true,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 02,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: CostumInput(
                                          Controller: VilleController,
                                          Label:
                                              "${_recruteur.entity!.city!.name}",
                                          Icon: Icon(Icons.location_city),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: InputPhoneNumber(
                                PhoneNumberController: PhoneNumberController,
                                Label: '${_recruteur.phoneNumber}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: InputEmail(
                                EmailController: EmailController,
                                Label: '${_recruteur.email}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: CostumInput(
                                Controller: JobController,
                                Label: "${_recruteur.entity!.job}",
                                Icon: Icon(Icons.person),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).height * 0.14,
                                  bottom: 20),
                              child: Container(
                                width: size.width * 0.9,
                                height: 55,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(6)),
                                child: GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      UpdateUserData();
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Mettre à jour mes informations",
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
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
