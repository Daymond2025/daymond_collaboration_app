import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:flutter/material.dart';

class FournisseursCommandesTermineScreen extends StatefulWidget {
  const FournisseursCommandesTermineScreen({Key? key}) : super(key: key);
  @override
  State<FournisseursCommandesTermineScreen> createState() =>
      _FournisseursCommandesTermineScreenState();
}

class _FournisseursCommandesTermineScreenState
    extends State<FournisseursCommandesTermineScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double fontsize = size.width <360 ? 11 :size.width > 383 && size.width < 390 ? 15 :22;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Text(
              'commande terminée',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            Spacer(),
            Text(
              '08 Jun 2020 10:10',
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
        ],
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 0,
                right: 12,
                left: 12,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Image.network(
                              'https://www.ivoiremobiles.net/21186-thickbox_default/samsung-galaxy-s21-ultra-128-go.jpg',
                              height: 80,
                              width: 80,
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 0, bottom: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      'Ordianteur portable HP FOLIO...',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(235, 14, 13, 13),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Montant réçu : ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    235, 14, 13, 13),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '70 000 FCFA',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ))
                                  ],
                                )),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                right: 12,
                left: 12,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12, top: 12),
                        child: Text(
                          'Détails de la commande',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Quantité',
                                        style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Prix parténaire',
                                        style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('2 pièces',
                                        style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      '70 000 FCFA / pièce',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        Text(
                          'Montant total reçu : ',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text('14.000 FCFA',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                right: 12,
                left: 12,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12, top: 12),
                        child: Text(
                          'Détails de la livraison',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Date de livraison',
                                        style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Lieux de livraison',
                                        style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('08 Jan. 2020 10:10',
                                        style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      'Yamoussoukro',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.blue),
                                    ),
                                  ),
                                  Icon(
                                    Icons.map,
                                    color: Colors.blue,
                                    size: 20,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                right: 12,
                left: 12,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey, width: 2)),
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(width: 2, color: grey))),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Autres détails",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const TextField(
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              hintText: "Texte",
                              focusedBorder: InputBorder.none,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                right: 12,
                left: 12,
              ),
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0, top: 0),
                    child: Text(
                      'Historique',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
