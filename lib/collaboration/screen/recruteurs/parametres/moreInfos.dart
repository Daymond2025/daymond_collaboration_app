// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/profil/badge_certifie_screen.dart';
import 'package:flutter/material.dart';

class MoreInfos extends StatefulWidget {
  const MoreInfos({
    Key? key,
  }) : super(key: key);

  @override
  _MoreInfosState createState() => _MoreInfosState();
}

class _MoreInfosState extends State<MoreInfos> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: black,
        title: Text("Plus d'informations".toUpperCase()),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 23),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(12),
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  offset: const Offset(0, 0.5),
                  color: Colors.grey.withOpacity(0.5),
                ),
              ],
            ),
            child: Center(
                child: Text(
              'COMPTE Recruteur'.toUpperCase(),
              style: TextStyle(fontSize: 16),
            )),
          ),
          SizedBox(
            height: 4,
          ),
          //// text 1
          Padding(
            padding:
                const EdgeInsets.only(top: 2.0, bottom: 4, left: 4, right: 4),
            child: Container(
              padding: EdgeInsets.all(12),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                        child: Icon(
                          Icons.lens_rounded,
                          color: Colors.black,
                          size: 8,
                        ),
                      ),
                      Text(
                        'Qu\'est ce que c\'est ?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 6, top: 10),
                    child: Column(
                      children: [
                        Text(
                            'Recruteur vendeur est un poste chez daymond qui vous donne un emploi de manière indépendante et qui vous fait gagner de l’argent en offrant de l’emploi a vos proches, vos amis, familles et vos connaissances.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //// text 2
          Padding(
            padding:
                const EdgeInsets.only(top: 2.0, bottom: 4, left: 4, right: 4),
            child: Container(
              padding: EdgeInsets.all(12),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                        child: Icon(
                          Icons.lens_rounded,
                          color: Colors.black,
                          size: 8,
                        ),
                      ),
                      Text(
                        'Quel est ma mission ?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4, right: 6, top: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BadgeCertifieScreen())),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'En tant que recruteur votre mission est de recenser des vendeurs pour le compte de daymond dans votre ville de manière professionnelle à l’aide des ressources misent à votre disposition dans le kit du ',
                                    style: TextStyle(color: black)),
                                TextSpan(
                                    text: 'Pack Daymond pro.\n\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: blue,
                                    )),
                                TextSpan(
                                    text:
                                        'Vous vous chargez de les inscrire gratuitement sur l’application daymond distribution depuis votre compte recruteur en seulement 2 minutes, ainsi vous gagnez de l’argent sur les 5 premiers marchés effectués par chaque vendeur que vous avez inscrit et un bonus Offert gratuitement par daymond.',
                                    style: TextStyle(color: black)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //// text 3
          Padding(
            padding:
                const EdgeInsets.only(top: 2.0, bottom: 4, left: 4, right: 4),
            child: Container(
              padding: EdgeInsets.all(12),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                        child: Icon(
                          Icons.lens_rounded,
                          color: Colors.black,
                          size: 8,
                        ),
                      ),
                      Text(
                        "Qu'est-ce que je gagne ?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 6, top: 10),
                    child: Column(
                      children: [
                        Text(
                            "En tant que recruteur des vendeurs Daymond, vous bénéficiez de plusieurs avantages financiers :\n •	150 F CFA de droit d’inscription, pour chaque vendeur recruté. \n•	2 500 F CFA de droit de recrutement, répartis à raison de 500 F CFA sur les 5 premières ventes réalisées par chaque vendeur que vous avez recruté. \n•	500 F CFA de bonus de coaching mensuel, valable pendant 1 an après les 5 premières ventes de chaque vendeur recruté (offre valable uniquement à l’activation de votre badge certifié). \n \n Vos gains sont instantanément crédités sur votre portefeuille numérique et peuvent être retirés à tout moment."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //// text 4
          Padding(
            padding:
                const EdgeInsets.only(top: 2.0, bottom: 4, left: 4, right: 4),
            child: Container(
              padding: EdgeInsets.all(12),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                        child: Icon(
                          Icons.lens_rounded,
                          color: Colors.black,
                          size: 8,
                        ),
                      ),
                      Text(
                        "Recommandation daymond ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 6, top: 10),
                    child: Column(
                      children: [
                        Text(
                            "Créer un groupe WhatsApp et ajouter tous les vendeurs daymond que vous avez inscrit depuis votre compte recruteur, dans le but de les motiver tous les jours afin de les amener à vendre plus de produits sur l’application daymond distribution et vous faire gagnez beaucoup plus d’argent plus rapidement. Car plus ils vendent mieux vous gagnez."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
