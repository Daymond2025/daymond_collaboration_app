import 'package:flutter/material.dart';

import '../../const/color.dart';
class FounisseurNouvelleCommandes extends StatefulWidget {
  const FounisseurNouvelleCommandes({Key? key}) : super(key: key);

  @override
  State<FounisseurNouvelleCommandes> createState() => _FounisseurNouvelleCommandesState();
}

class _FounisseurNouvelleCommandesState extends State<FounisseurNouvelleCommandes> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontsize = size.width <360 ? 11 :size.width > 383 && size.width < 390 ? 14 : 16;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Text('Nouvelle commande ',style: TextStyle(color: Colors.black,fontSize: 12),),
            Spacer(),
            Text('08 Jun 2020 10:10',style: TextStyle(color: Colors.black,fontSize: 8),),
          ],
        ),
        actions: [

          IconButton(
              onPressed: (){},
              icon: Icon(Icons.delete)
          ),
        ],
      ),
      body:  Container(
        color: Colors.grey.shade200,
        child: ListView(
          children: <Widget> [
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(top: 0,right: 12,left: 12,),
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
                              height: 100,
                              width: 100,
                            ),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 0,bottom: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      'Ordianteur portable HP FOLIO...',
                                      style: TextStyle(
                                        fontSize: fontsize,
                                        color: Color.fromARGB(235, 14, 13, 13),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Montant réçu : ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(235, 14, 13, 13),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text('80 000 FCFA',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                                          ],
                                        )

                                    )
                                  ],
                                )
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 0,left: 0),
                                  child:  Text('X3'),
                                )
                              ],
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12,right: 12,left: 12,),
              child:  Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child:Padding(
                        padding: EdgeInsets.only(bottom: 12,top: 12),
                        child: Text('Détails de la commande',style: TextStyle(fontSize: 16),) ,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child:  Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Quantité',style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Prix parténaire',style: TextStyle(fontSize: 14)),
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
                                    child: Text('2 pièces',style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('70 000 FCFA / pièce',style: TextStyle(fontSize: 14),),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey,),
                    Row(
                      children: [
                        Text('Montant total reçu : ',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text('14.000 FCFA',  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            ),
           SizedBox(height: 6,),
            Padding(
              padding: EdgeInsets.only(top: 0,right: 12,left: 12,),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex:3,
                          child: Text('Produits suplémentaire',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                        Expanded(
                          flex:3,
                          child:  Divider(color: Colors.grey,),
                        )
                      ],
                    ),
                    SizedBox(height: 6,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: Image.network(
                                  'https://p.kindpng.com/picc/s/151-1517817_transparent-computadoras-png-desktop-computer-png-download.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 0,bottom: 10),
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
                                        SizedBox(height: 10,),
                                        Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Montant réçu : ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(235, 14, 13, 13),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text('80 000 FCFA',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                              ],
                                            )
                                        )
                                      ],
                                    )
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 0,left: 0),
                                      child:  Text('X2'),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 6,right: 12,left: 12,),
              child:  Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child:Padding(
                        padding: EdgeInsets.only(bottom: 6,top: 6),
                        child: Text('Information de la commande',style: TextStyle(fontSize: fontsize),) ,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child:  Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Montant total ',style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Remise',style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Frais livraison',style: TextStyle(fontSize: 14)),
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
                                    child: Text('24.000 Fcfa',style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('- 2000 Fcfa',style: TextStyle(fontSize: 14),),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('- 2000 Fcfa',style: TextStyle(fontSize: 14),),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey,),
                    Row(
                      children: [
                        Text('Montant total reçu : ',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text('20.000 FCFA',  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 12,right: 12,left: 12,),
              child:  Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child:Padding(
                        padding: EdgeInsets.only(bottom: 12,top: 12),
                        child: Text('Détails de la livraison',style: TextStyle(fontSize: 16),) ,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child:  Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Date de livraison',style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Lieux de livraison',style: TextStyle(fontSize: 14)),
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
                                    child: Text('08 Jan. 2020 10:10',style: TextStyle(fontSize: 14)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Yamoussoukro',style: TextStyle(fontSize: 14,color: Colors.blue),),
                                  ),
                                  Icon(Icons.map,color: Colors.blue,size: 20,)
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
              padding: EdgeInsets.only(top: 12,right: 12,left: 12,),
              child:  Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: grey,width: 2)),
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            decoration: const BoxDecoration(border:Border(bottom: BorderSide(width: 2,color: grey))),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text("Autres détails",textAlign: TextAlign.center,),
                            ),
                          ),

                          const TextField(
                            maxLines: 3,
                            textAlign:TextAlign.start,
                            decoration: InputDecoration(hintText: "Texte",
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
            InkWell(
              child: Padding(
                padding: EdgeInsets.only(top: 12,right: 12,left: 12,),
                child:  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0,top: 0),
                      child: Text('Historique',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),) ,
                    )
                ),
              ),
              onTap: (){
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  builder: (context) => DraggableScrollableSheet(
                      initialChildSize: 0.50,
                      maxChildSize: 0.5,
                      minChildSize: 0.28,
                      expand: false,
                      builder: (context, ScrollController) {
                        return SingleChildScrollView(
                          controller: ScrollController,
                          child: Container(

                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(111, 224, 223, 223)
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: const Offset(1, 3),
                                        ),
                                      ],
                                      border: const Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    child:ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 12),
                                              child: Text(
                                                'Historique',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          15.0, 0.0, 15.0, 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text('Commande réçu ',style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text('Marqué en preparation',style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text('Prète pour livraison',style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text('Marqué annuler',style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text('Marqué terminer',style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                          ),
                                          Expanded(

                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text('Jeudi 12 Jan.22 10:02',style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                  Row(

                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text('Jeudi 12 Jan.22 10:06',style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text('Jeudi 12 Jan.22 11:12',style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text('Jeudi 12 Jan.22 14:28',style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(12),
                                                        child: Text("Aujourd'hui 12:17",style: TextStyle(fontSize: 14),),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
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
