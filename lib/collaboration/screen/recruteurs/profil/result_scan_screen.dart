import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/screen/home_recruteurs_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_badge_certifie.dart';
import 'package:flutter/material.dart';

class ResultScanncodeScreen extends StatefulWidget {
  const ResultScanncodeScreen({Key? key, required this.text}) : super(key: key);
  final text;
  @override
  State<ResultScanncodeScreen> createState() => _ResultScanncodeScreenState();
}

class _ResultScanncodeScreenState extends State<ResultScanncodeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final demande_badge_certifie = ServiceBadgeCertifie();
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(color: blue),
            child: Stack(
              children: [
                _buildScan(context),
                Positioned(
                  top: size.height * 0.86,
                  left: size.width * 0.25,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeRecruteurScreen()),
                          (route) => false);
                    },
                    child: Container(
                        padding: EdgeInsets.all(12),
                        height: size.height * 0.064,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: white, width: 2),
                        ),
                        child: Text(
                          'OK',
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _buildScan(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Card(
          elevation: 2.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            width: 300,
            height: size.height * 0.38,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 300,
                  width: 280,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: white,
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/badge_CERTIFIER.png",
                                    ),
                                    fit: BoxFit.contain)),
                            height: size.height * 0.17,
                            width: size.width * 0.5,
                          ),
                        ),
                        Text(
                            "Félicitation votre badge a été certifié avec succès, porifitez de ces avantages",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: blue)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.5,
                  left: size.width * 0.24,
                  child: Text(
                    widget.text,
                    style: TextStyle(color: Colors.black26),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
