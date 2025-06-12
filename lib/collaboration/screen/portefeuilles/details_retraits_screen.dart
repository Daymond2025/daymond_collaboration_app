import 'package:flutter/material.dart';

class DetailsRetraitsScreen extends StatefulWidget {
  const DetailsRetraitsScreen({
    Key? key,
    required this.logo_operator,
    required this.montant_retire,
    required this.numero_retrait,
    required this.numero_refrence,
    required this.sold_courant,
    required this.date_retrait,
  }) : super(key: key);
  final logo_operator;
  final montant_retire;
  final numero_retrait;
  final numero_refrence;
  final sold_courant;
  final date_retrait;
  @override
  State<DetailsRetraitsScreen> createState() =>
      _FournisseursDetailsRetraitsScreenState();
}

class _FournisseursDetailsRetraitsScreenState
    extends State<DetailsRetraitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Détails de transaction',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/checked.png',
                    width: 60,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Retrait éffectué',
                    style: TextStyle(
                        color: Color.fromRGBO(14, 189, 2, 100), fontSize: 20),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('MONTANT RETIRÉ'),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 30, top: 4),
                                      child: Text(
                                        '${widget.montant_retire} FCFA',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('NUMÉRO DU RÉTRAIT'),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 10, top: 4),
                                      child: Text(
                                        '${widget.numero_retrait}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('REFERENCE DU RETRAIT'),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 40, top: 4),
                                      child: Text(
                                        '${widget.numero_refrence}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // Column(
                                //   children: [
                                //     Text('SOLDE APRÈS RETRAIT'),
                                //     Padding(
                                //       padding:
                                //           EdgeInsets.only(right: 70, top: 4),
                                //       child:
                                //           Text('${widget.sold_courant}  FCFA'),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/mobile/wave.png'))),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Center(
          child: Text('Retiré le ${widget.date_retrait}'),
        ),
      ),
    );
  }
}
