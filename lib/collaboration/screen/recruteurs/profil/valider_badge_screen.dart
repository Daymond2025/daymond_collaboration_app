// ignore_for_file: file_names

// import 'dart:io';

// import 'package:collaboration/components/ValiderBage/ScanButton.dart';
// import 'package:collaboration/const/color.dart';
// import 'package:collaboration/const/contants.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

/*
class ValiderBadgeScreen extends StatefulWidget {
  const ValiderBadgeScreen({Key? key}) : super(key: key);

  @override
  State<ValiderBadgeScreen> createState() => _ValiderBadgeState();
}

class _ValiderBadgeState extends State<ValiderBadgeScreen> {
  @override
  final qrkey = GlobalKey(debugLabel: 'QR');
  bool valide_qrcode = false;
  Barcode? barcode;
  QRViewController? controller;
  whatsapp() async{
    var androidUrl = "whatsapp://send?phone=$WhatsAppContact&text=";
    var iosUrl = "https://wa.me/$WhatsAppContact?text=${Uri.parse('')}";
    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp n'est pas installé sur l'appareil"),
        ),
      );
    }
  }
  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  @override
  void reassemble() async{
    super.reassemble();
    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color:bludeBold,size: 30),
        elevation: 2,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title:  Text("valider le badge".toUpperCase(),),
        centerTitle: true,
        titleTextStyle: const TextStyle(color:black,fontSize: 18),
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Text("Scanner le code QR sur le pack daymond pro \npour validé votre badge",
                  textAlign: TextAlign.center,
                  style:  TextStyle(fontSize: 16),),

                valide_qrcode ? Padding(
                  padding:  EdgeInsets.only(top: size.height*0.05),
                  child: QRBarcode(),
                ) : Center(
                  child: Padding(
                    padding:  EdgeInsets.only(top:size.height*0.05,bottom: 10),
                    child: Stack(
                      children: [
                        Container(
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: white,
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/qrcde.png",
                                  ),
                                  fit: BoxFit.contain)
                          ),
                          height: size.height*0.36,
                          width: size.width,

                        ),

                      ],
                    ),
                  ),
                ),
                valide_qrcode ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ScanButton(text: "Annuler",
                    press: (){
                    setState(() {
                      valide_qrcode = !valide_qrcode;
                    });
                  },),
                )
                    :
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ScanButton(text: "Scanner",
                    press: (){
                      setState(() {
                        valide_qrcode = !valide_qrcode;
                      });
                    },),
                ),
                const Divider(),
                Padding(
                  padding:  EdgeInsets.only(top: size.height*0.13,bottom: 20.0,right: 20,left: 20),
                  child: TextButton(
                      onPressed: (){
                        whatsapp();
                      },
                     child:  Text("Code QR invalide contacter le service", style:  TextStyle(fontSize: 15,color: blue))),
                )
              ],
            ),
          )
        ],
      ),

    );

  }
}*/