import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class CompteFournisseur extends StatefulWidget {
  const CompteFournisseur({super.key});

  @override
  State<CompteFournisseur> createState() => _CompteFournisseurState();
}

class _CompteFournisseurState extends State<CompteFournisseur> {
  String data1 = '';
  String data2 = '';
  String data3 = '';
  String data4 = '';
  //
  textData() async {
    String text1;
    String text2;
    String text3;
    String text4;

    //
    text1 = await rootBundle.loadString('files/Text1_fournisseur.txt');
    text2 = await rootBundle.loadString('files/Text2_fournisseur.txt');
    text3 = await rootBundle.loadString('files/Text3_fournisseur.txt');
    text4 = await rootBundle.loadString('files/Text4_fournisseur.txt');

    //
    setState(() {
      data1 = text1;
      data2 = text2;
      data3 = text3;
      data4 = text4;
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
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          title: Container(
            padding: const EdgeInsets.only(top: 45),
            alignment: Alignment.topCenter,
            child: const Text(
              'Plus d\'informations',
              style: TextStyle(fontSize: 15),
            ),
          ),
          elevation: 2,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 15, top: 20, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: const Text(
                'COMPTE RECRUTEUR FOURNISSEUR',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 20, top: 10),
          child: Column(
            children: [
              //'Qu\'est ce que c\'est ?',
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
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
                      padding:
                          const EdgeInsets.only(left: 4, right: 6, top: 10),
                      child: Text(data1),
                    ),
                  ],
                ),
              ),

              // 'Quelle est ma mission ?'
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                          child: Icon(
                            Icons.lens_rounded,
                            color: Colors.black,
                            size: 8,
                          ),
                        ),
                        Text(
                          'Quelle est ma mission ?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                        top: 10,
                        right: 6,
                      ),
                      child: Text(data2),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 6),
                      child: Text(data3),
                    ),
                  ],
                ),
              ),

              // 'Qu\'est ce que je gagne ?',
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
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
                          'Qu\'est ce que je gagne ?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 4, top: 10, right: 6),
                      child: Text(data4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
