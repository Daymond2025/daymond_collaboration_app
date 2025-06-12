// ignore_for_file: file_names
import 'dart:io';

import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CentreAssistant extends StatefulWidget {
  const CentreAssistant({Key? key}) : super(key: key);

  @override
  State<CentreAssistant> createState() => _CentreAssistantState();
}

class _CentreAssistantState extends State<CentreAssistant> {
  whatsapp() async {
    var androidUrl = "whatsapp://send?phone=$contact_whatsap&text=";
    var iosUrl = "https://wa.me/$contact_whatsap?text=${Uri.parse('')}";
    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp n'est pas installé sur l'appareil"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: black),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: black, fontSize: 20),
        title: const Text(
          "Centre d'assistance",
          style: TextStyle(color: black),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: blue,
                  image: const DecorationImage(
                      image: AssetImage(
                        "assets/images/prod1.png",
                      ),
                      fit: BoxFit.cover)),
              height: 150,
              width: double.infinity,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Bienvenu au service d’assistant daymond collaboration sélectionnez le moyen le plus facile pour vous de nous contactez cas nous vous attendons pour répondre a vos préoccupation.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.35, right: size.width * 0.35, top: 10),
              child: const Divider(
                color: Colors.grey,
                thickness: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                child: ListTile(
                  onTap: () async {
                    String message = "";
                    // List<String> recipents = ["${WhatsAppContact}"];
                    final Uri launchUri = Uri(
                      scheme: 'sms',
                      path: WhatsAppContact,
                      queryParameters: <String, String>{
                        'body': message,
                      },
                    );
                    await launchUrl(launchUri);
                    // String _result = await sendSMS(message: message, recipients: recipents, sendDirect: false)
                    //     .catchError((onError) {
                    //   print(onError);
                    // });
                    // print(_result);
                  },
                  title: Text(
                    "Message daymond",
                    style: TextStyle(fontSize: 20, color: black),
                  ),
                  leading: Icon(
                    Icons.sms,
                    color: black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: ListTile(
                onTap: () {
                  whatsapp();
                },
                title: Text(
                  "WhatsApp direct",
                  style: TextStyle(fontSize: 20, color: black),
                ),
                leading: Image.asset(
                  'assets/images/whatsapp.png',
                  color: Colors.black,
                  width: 20,
                ),
              ),
            ),
            GestureDetector(
              child: ListTile(
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: WhatsAppContact,
                  );
                  await launchUrl(launchUri);
                  // FlutterPhoneDirectCaller.callNumber('${WhatsAppContact}');
                },
                title: Text(
                  "Appel téléphonique",
                  style: TextStyle(fontSize: 20, color: black),
                ),
                leading: Icon(
                  Icons.phone,
                  color: black,
                ),
              ),
            ),
            GestureDetector(
              child: ListTile(
                onTap: () async {
                  String email = Uri.encodeComponent(
                      "contact.daymondcollaboration@gmail.com");
                  String subject = Uri.encodeComponent(
                      "Service assistant Daymond collaboration");
                  String body = Uri.encodeComponent("");
                  print(subject); //output: Hello%20Flutter
                  Uri mail =
                      Uri.parse("mailto:$email?subject=$subject&body=$body");
                  if (await launchUrl(mail)) {
                    //email app opened
                  } else {
                    //email app is not opened
                  }
                },
                title: Text(
                  "E-mail",
                  style: TextStyle(fontSize: 20, color: black),
                ),
                leading: Icon(
                  Icons.attach_email,
                  color: black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: size.width * 0.3,
                  right: size.width * 0.3,
                  top: size.height * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://www.facebook.com/share/LTTS8tXRcQG3nZd9/'));
                      },
                      icon: Image.asset(
                        'assets/images/facebook_f.png',
                        width: 25,
                      )),
                  IconButton(
                    onPressed: () {
                      launchUrl(Uri.parse(
                          'https://www.instagram.com/daymond_official?igsh=YzdjdW13cmNmMTU1'));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Container(alignment: Alignment.center, child: Text('Suivez-nous'))
          ],
        ),
      )),
    );
  }
}
