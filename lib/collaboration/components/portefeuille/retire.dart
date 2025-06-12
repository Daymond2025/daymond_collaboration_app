import 'package:daymond_collaboration_app/collaboration/api_response.dart';

import 'package:daymond_collaboration_app/collaboration/const/contants.dart';

import 'package:daymond_collaboration_app/collaboration/screen/portefeuilles/details_retraits_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/transaction_service.dart';
import 'package:flutter/material.dart';

class PortefeuilleRetraitCard extends StatefulWidget {
  const PortefeuilleRetraitCard({super.key, required this.sommeRetire});
  final sommeRetire;
  @override
  State<PortefeuilleRetraitCard> createState() =>
      _FournisseurRetraitWidgetState();
}

class _FournisseurRetraitWidgetState extends State<PortefeuilleRetraitCard> {
  List<dynamic> _retraits = [];
  bool _loading = true;
  double sommeTotalRetire = 0.0;

  //get all transaction
  Future transactions() async {
    ApiResponse response = await TransactionService().getAllTransactions();

    if (response.error == null) {
      setState(() {
        _retraits = response.data as List<dynamic>;
        _loading = false;
      });
    } else if (response.error == unauthorized) {
    } else {
      // print(response.error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    transactions();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _retraits.isEmpty
              ? Center(
                  child: Text('Liste vide...'),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey.shade100,
                  child: SizedBox(
                    height: size.height * 0.67,
                    child: ListView.builder(
                        itemCount: _retraits.length,
                        itemBuilder: (context, int index) {
                          sommeTotalRetire += double.parse(
                              _retraits[index]['amount'].toString());
                          // print(sommeTotalRetire);
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsRetraitsScreen(
                                          logo_operator: _retraits[index]
                                                      ['operator'] ==
                                                  'Orange'
                                              ? 'assets/mobile/orange.png'
                                              : _retraits[index]['operator'] ==
                                                      'Mtn'
                                                  ? 'assets/mobile/mtn.png'
                                                  : _retraits[index]
                                                              ['operator'] ==
                                                          'Moov'
                                                      ? 'assets/mobile/moov.png'
                                                      : _retraits[index][
                                                                  'operator'] ==
                                                              'wave'
                                                          ? 'assets/mobile/wave.png'
                                                          : '',
                                          montant_retire:
                                              '${_retraits[index]['amount']}',
                                          numero_retrait:
                                              '${_retraits[index]['phone_number']}',
                                          numero_refrence:
                                              '${_retraits[index]['reference']}',
                                          sold_courant: '0',
                                          date_retrait:
                                              '${FormatDateHour('${_retraits[index]['created_at']}')}',
                                        ))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                GestureDetector(
                                  child: kCardRetait(
                                    context,
                                    capitalize('Retrait'.toString()),
                                    _retraits[index]['operator'] == 'Orange'
                                        ? 'assets/mobile/orange.png'
                                        : _retraits[index]['operator'] == 'Mtn'
                                            ? 'assets/mobile/mtn.png'
                                            : _retraits[index]['operator'] ==
                                                    'Moov'
                                                ? 'assets/mobile/moov.png'
                                                : _retraits[index]
                                                            ['operator'] ==
                                                        'Wave'
                                                    ? 'assets/mobile/wave.png'
                                                    : '',
                                    FormatDate(
                                        '${_retraits[index]['created_at']}'),
                                    '${_retraits[index]['amount']} Fcfa',
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),
      bottomSheet: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.0),
        ),
        padding: EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Montant total retiré',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                '${sommeTotalRetire} Fcfa',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

Container kCardRetait(BuildContext context, String nom, final image,
    String minute, String commission) {
  return Container(
    padding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                  leading: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/mobile/wave.png'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 2,
                    ),
                    child: Text(
                      '${nom}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      'Retiré le ${minute}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Text('${commission} CFA',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )),
            ],
          ),
        ),
        Container(
          height: 7,
        ),
      ],
    ),
  );
}
