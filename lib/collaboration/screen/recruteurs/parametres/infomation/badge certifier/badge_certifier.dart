import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/profil/badge_certifie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class BadgeCertifier extends StatefulWidget {
  const BadgeCertifier({super.key});

  @override
  State<BadgeCertifier> createState() => _BadgeCertifierState();
}

class _BadgeCertifierState extends State<BadgeCertifier> {
  String data1 = '';
  String data2 = '';
  String data3 = '';
  String data4 = '';
  String data5 = '';
  String data6 = '';
  //
  textData() async {
    String text1;
    String text2;
    String text3;
    String text4;
    String text5;
    String text6;
    //
    text1 = await rootBundle.loadString('files/Text1_badgecert.txt');
    text2 = await rootBundle.loadString('files/Text2_badgecert_vend.txt');
    text3 = await rootBundle.loadString('files/Text3_badgecert_vend.txt');
    text4 = await rootBundle.loadString('files/Text4_badgecert_vend.txt');
    text5 = await rootBundle.loadString('files/Text5_badgecert_vend.txt');
    text6 = await rootBundle.loadString('files/Text1_badgecert_fournis.txt');
    //
    setState(() {
      data1 = text1;
      data2 = text2;
      data3 = text3;
      data4 = text4;
      data5 = text5;
      data6 = text6;
    });
  }

  @override
  void initState() {
    textData(); //set the initial value of text field

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        backgroundColor: black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'BADGE CERTIFIE',
          style: TextStyle(fontSize: 23),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text(
                        'COMPTE Recruteur'.toUpperCase(),
                        style: TextStyle(fontSize: 16),
                      )),
                  //
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2.0, bottom: 4, left: 4, right: 4),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 8),
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
                            padding: const EdgeInsets.only(
                                left: 4, right: 6, top: 10),
                            child: Text(data1),
                          ),
                          const Text(
                            '100%',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4,
                              right: 6,
                            ),
                            child: Text(data2),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2.0, bottom: 4, left: 4, right: 4),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, right: 8),
                                  child: Icon(
                                    Icons.lens_rounded,
                                    color: Colors.black,
                                    size: 8,
                                  ),
                                ),
                                Text(
                                  'Quels sont les avantages?',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, bottom: 10, top: 10),
                              child: Text(data3),
                            ),
                            // 1
                            Container(
                                alignment: Alignment.topCenter,
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '1. ',
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'Bonus de 500 F CFA à vie : Obtenez gratuitement de Daymond un bonus à vie de 500 F CFA après les 5 premières ventes des vendeurs que vous avez recrutés. Ainsi, vous gagnez beaucoup plus sur le long terme, avec des gains illimités, au lieu de 2 500 F CFA seulement par vendeur recruté.',
                                          style: TextStyle(
                                              color: black, fontSize: 13)),
                                    ],
                                  ),
                                )),

                            //2
                            Container(
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          child: const Text(
                                            '2.',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: const Text(
                                            'Augmentation de vos gains de plus de 100 %.'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //3
                            Container(
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: const Text(
                                            '3.',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: const Text(
                                          'Adhésion à la liste des utilisateurs privilégiés de Daymond.',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //4
                            Container(
                                alignment: Alignment.topCenter,
                                padding: const EdgeInsets.only(top: 15),
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '4. ',
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'Présentation professionnelle grâce aux outils mis à disposition.',
                                          style: TextStyle(
                                              color: black, fontSize: 13)),
                                    ],
                                  ),
                                )),
                            // 5
                            Container(
                                alignment: Alignment.topCenter,
                                padding: const EdgeInsets.only(top: 15),
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '5. ',
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'Kit Daymond Pro : En plus des avantages en ligne, recevez un kit d’activation Daymond Pro comprenant un tee-shirt, une casquette, un badge professionnel, ainsi qu’un code d’activation pour votre badge certifié.',
                                          style: TextStyle(
                                              color: black, fontSize: 13)),
                                    ],
                                  ),
                                )),
                            //
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BadgeCertifieScreen()));
                                },
                                child: const Text(
                                  'Voir les accessoires',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2.0, bottom: 4, left: 4, right: 4),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 8),
                                child: Icon(
                                  Icons.lens_rounded,
                                  color: Colors.black,
                                  size: 8,
                                ),
                              ),
                              Text(
                                'Terme et condition',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, bottom: 10, top: 10),
                            child: Text(
                                "Nous tenons à vous rappeler que le contenu du Pack Daymond Pro vous a été délivré en tant que recruteur Daymond, dont la mission est de recruter des agents de vente, conformément aux CGU de l'application Daymond Collaboration."),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, bottom: 10, top: 10),
                            child: Column(
                              children: [
                                Text(
                                    "Il est strictement interdit d'utiliser le Pack Daymond Pro à des fins autres que sa mission initiale. Toute utilisation détournée expose à des poursuites judiciaires et à des sanctions financières importantes."),
                                Text(
                                    "De plus, l'utilisation non autorisée du Pack Daymond Pro peut entraîner des dommages irréparables à la réputation de la société Daymond."),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            //
            //FOURNISSEUR
            /*
            Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 15, top: 20, bottom: 15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const Text(
                      'RECRUTEUR FOURNISSEUR',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 12, 19, 247),
                      ),
                    ),
                  ),
                  //
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, bottom: 20),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 8, bottom: 8, right: 8),
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
                          padding:
                              const EdgeInsets.only(left: 4, right: 6, top: 10),
                          child: Text(data1),
                        ),
                        const Text(
                          '100%',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 6),
                          child: Text(data2),
                        ),
                      ],
                    ),
                  ),
                  //
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, bottom: 20),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 8, bottom: 8, right: 8),
                              child: Icon(
                                Icons.lens_rounded,
                                color: Colors.black,
                                size: 8,
                              ),
                            ),
                            Text(
                              'Quels sont les avantages?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4, right: 4, bottom: 10, top: 10),
                          child: Text(data3),
                        ),
                        // 1
                        Container(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 60),
                                      child: const Text(
                                        '1.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: data6,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          children: const [
                                            TextSpan(
                                              text:
                                                  '(Tee-shirt, Polo,\nCasquette, Badge professionnel et un\nCode de validation pour un badge certifié.)',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 8),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BadgeCertifieScreen()));
                            },
                            child: const Text(
                              'Voir les accessoires',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),

                        //2
                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 32),
                                      child: const Text(
                                        '2.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Text(
                                        'Gagner 1.000 FCFA sur chaque produit\nvalidé par mission spéciale au lieu de\n500 FCFA.'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //3

                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: const Text(
                                        '3.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Text(
                                      'Présentation professionnelle à l\'aide des\noutils mis à disposition.',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //4
                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: const Text(
                                        '4.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Text(
                                      'Adhésion à la liste des utilisateurs privilégiés\nde Daymond',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // 5
                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: const Text(
                                        '5.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Text(
                                        'L\'augmentation de vos gains a plus de 100%'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           * */
          ],
        ),
      ),
    );
  }
}
