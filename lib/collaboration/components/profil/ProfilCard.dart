// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names
import 'dart:io';

import 'package:daymond_collaboration_app/collaboration/models/statistique_model.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/details_vendeurs_niveaux.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilCard extends StatefulWidget {
  ProfilCard(
      {Key? key,
      required this.date,
      required this.user_id,
      required this.name,
      required this.value,
      required this.profilPicture,
      required this.contactWat,
      required this.sellerStats,
      required this.CardColor})
      : super(key: key);
  String user_id;
  final name;
  final date;
  final profilPicture;
  final contactWat;
  Widget value;
  Color CardColor;
  final SellerStats? sellerStats;
  @override
  State<ProfilCard> createState() => _ProfilCardState();
}

class _ProfilCardState extends State<ProfilCard> {
  whatsapp() async {
    var contact = "${widget.contactWat}";
    var androidUrl = "whatsapp://send?phone=$contact&text=";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('')}";
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
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.CardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsVendeurByNiveaux(
                              vendeur_id: widget.user_id,
                              sellerStats: widget.sellerStats,
                            )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: widget.profilPicture == null
                        ? AssetImage('assets/images/user.png')
                        : NetworkImage("${widget.profilPicture}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      width: size.width / 2.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width < 350 ? 13 : 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.date,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                widget.contactWat == "0" ? null : whatsapp();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.value,
              ),
            )
          ],
        ),
      ),
    );
  }
}
