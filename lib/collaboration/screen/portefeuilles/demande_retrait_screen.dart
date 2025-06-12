import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/services/transaction_service.dart';

import 'package:daymond_collaboration_app/collaboration/components/input/InputPhoneNumber.dart';
import 'package:daymond_collaboration_app/collaboration/screen/portefeuilles/ClickNumeroRetraitScreen.dart';
import 'package:flutter/material.dart';

class FournisseurPortefeuilleRetraitScreen extends StatefulWidget {
  const FournisseurPortefeuilleRetraitScreen({super.key});

  @override
  State<FournisseurPortefeuilleRetraitScreen> createState() =>
      _FournisseurPortefeuilleRetraitScreenState();
}

class _FournisseurPortefeuilleRetraitScreenState
    extends State<FournisseurPortefeuilleRetraitScreen> {
  bool _wave = false;
  bool _same_number = false;
  String? formatedDate;
  final transactionService = TransactionService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController contact1Controller = TextEditingController();
  TextEditingController contact2Controller = TextEditingController();
  TextEditingController montantController = TextEditingController();
  // List<ContactTransaction> _contacts = [];
  bool loading = true;

  //add contact transaction

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black54),
          title: const Text(
            'RETRAIT ARGENT',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 245, 245),
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Dialog(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            insetPadding: const EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              Container(
                                // height: 50,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    const Text(
                                      "Retirer de l'argent de votre portefeuille",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Text(
                                      "ver votre compte Wave",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ), //opateru
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              // Expanded(
                              //   flex: 1,
                              //   child: Container(
                              //     padding: const EdgeInsets.all(2),
                              //     decoration: BoxDecoration(
                              //       color: _orange ? blue : white,
                              //       borderRadius: BorderRadius.circular(6.0),
                              //     ),
                              //     child: InkWell(
                              //       onTap: () {
                              //         setState(() {
                              //           // _orange = true;
                              //           // _mtn = false;
                              //           // _moov = false;
                              //           _wave = false;
                              //         });
                              //       },
                              //       child: Container(
                              //         padding: EdgeInsets.all(5),
                              //         decoration: BoxDecoration(
                              //           color: white,
                              //           boxShadow: const [
                              //             BoxShadow(
                              //               color:
                              //                   Color.fromARGB(36, 158, 158, 158),
                              //               blurRadius: 5,
                              //               offset: Offset(1, 2),
                              //             ),
                              //             BoxShadow(
                              //               color:
                              //                   Color.fromARGB(54, 158, 158, 158),
                              //               blurRadius: 5,
                              //               offset: Offset(2, 1),
                              //             ),
                              //           ],
                              //           borderRadius: BorderRadius.circular(6.0),
                              //         ),
                              //         child: Column(
                              //           children: [
                              //             Image.asset('assets/mobile/orange.png'),
                              //             const Text('Orange')
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: _wave ? blue : white,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        // _orange = false;
                                        // _mtn = false;
                                        // _moov = false;
                                        _wave = true;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: white,
                                        border: Border.all(color: blue),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                36, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(1, 2),
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                54, 158, 158, 158),
                                            blurRadius: 5,
                                            offset: Offset(2, 1),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/mobile/wave.png',
                                            height: 100,
                                          ),
                                          const Text('Wave')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: Container(
                              //     padding: EdgeInsets.all(2),
                              //     decoration: BoxDecoration(
                              //       color: _mtn ? blue : white,
                              //       borderRadius: BorderRadius.circular(6.0),
                              //     ),
                              //     child: InkWell(
                              //       onTap: () {
                              //         setState(() {
                              //           _orange = false;
                              //           _mtn = true;
                              //           _moov = false;
                              //           _wave = false;
                              //         });
                              //       },
                              //       child: Container(
                              //         padding: EdgeInsets.all(5),
                              //         decoration: BoxDecoration(
                              //           color: white,
                              //           boxShadow: const [
                              //             BoxShadow(
                              //               color:
                              //                   Color.fromARGB(36, 158, 158, 158),
                              //               blurRadius: 5,
                              //               offset: Offset(1, 2),
                              //             ),
                              //             BoxShadow(
                              //               color:
                              //                   Color.fromARGB(54, 158, 158, 158),
                              //               blurRadius: 5,
                              //               offset: Offset(2, 1),
                              //             ),
                              //           ],
                              //           borderRadius: BorderRadius.circular(6.0),
                              //         ),
                              //         child: Column(
                              //           children: [
                              //             Image.asset('assets/mobile/mtn.png'),
                              //             const Text('MTN')
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Expanded(
                              //   flex: 1,
                              //   child: Container(
                              //     padding: EdgeInsets.all(2),
                              //     decoration: BoxDecoration(
                              //       color: _moov ? blue : white,
                              //       borderRadius: BorderRadius.circular(6.0),
                              //     ),
                              //     child: InkWell(
                              //       onTap: () {
                              //         setState(() {
                              //           _orange = false;
                              //           _mtn = false;
                              //           _moov = true;
                              //           _wave = false;
                              //         });
                              //       },
                              //       child: Container(
                              //         padding: EdgeInsets.all(5),
                              //         decoration: BoxDecoration(
                              //           color: white,
                              //           boxShadow: const [
                              //             BoxShadow(
                              //               color:
                              //                   Color.fromARGB(36, 158, 158, 158),
                              //               blurRadius: 5,
                              //               offset: Offset(1, 2),
                              //             ),
                              //             BoxShadow(
                              //               color:
                              //                   Color.fromARGB(54, 158, 158, 158),
                              //               blurRadius: 5,
                              //               offset: Offset(2, 1),
                              //             ),
                              //           ],
                              //           borderRadius: BorderRadius.circular(6.0),
                              //         ),
                              //         child: Column(
                              //           children: [
                              //             Image.asset('assets/mobile/moov.png'),
                              //             const Text('Moov')
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Container(
                                        //alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 5),
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: TextField(
                                          controller: montantController,
                                          keyboardType: TextInputType.number,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: blue)),
                                              focusedBorder:
                                                  new OutlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(
                                                              color: blue)),
                                              hintText: '10 000',
                                              labelText: 'Montant à retirer',
                                              labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 20),
                                              prefixText: ' ',
                                              suffixText: 'Fr',
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 20),
                                              suffixStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 20)),
                                        ),
                                      )),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: InputPhoneNumber(
                                        Label: 'Numéro de téléphone',
                                        PhoneNumberController:
                                            contact1Controller),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: InputPhoneNumber(
                                          Label:
                                              'Confirmer numéro de téléphone',
                                          PhoneNumberController:
                                              contact2Controller)),
                                  _same_number
                                      ? Text(
                                          'Veuillez réessayer avec des numéros correct',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                          textAlign: TextAlign.center,
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (_formKey.currentState!.validate()) {
                                        var response = await transactionService
                                            .demandeRetraits(
                                                montantController.text,
                                                contact2Controller.text,
                                                "Wave");
                                        print(response.data);
                                        if (response.data == 200) {
                                          setState(() {
                                            loading = false;
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                    content: Container(
                                                      height: 250,
                                                      width: 300,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 100,
                                                            width: 100,
                                                            child: Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green,
                                                              size: 100,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                              'Votre demande de retrait a bien eté envoyé!'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text(
                                                          'OK',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                        } else {
                                          setState(() {
                                            loading = false;
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                    content: Container(
                                                      height: 200,
                                                      width: 300,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 100,
                                                            width: 100,
                                                            child: Icon(
                                                              Icons.error,
                                                              color: Colors.red,
                                                              size: 100,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                              'Erreur lors de l\'envoi de votre demande de retrait'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text(
                                                          'OK',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                        }
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: blue,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Envoyer',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: null,
    );
  }

  InkWell kOperateurNumero(String image, String operateur, String numero) =>
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClickNumeroRetraitScreen(
              image: image,
              operateur: operateur,
              numero: numero,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover)),
              ),
              title: Text(
                operateur,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  numero,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      );
}
