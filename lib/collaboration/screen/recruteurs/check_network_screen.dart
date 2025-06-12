import 'package:daymond_collaboration_app/collaboration/LoadingScreen.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:flutter/material.dart';
class CheckNetworkScreen extends StatefulWidget {
  const CheckNetworkScreen({super.key});

  @override
  State<CheckNetworkScreen> createState() => _CheckNetworkScreenState();
}

class _CheckNetworkScreenState extends State<CheckNetworkScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: size.height*0.3),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/wifi.png')
                  )
              ),
            ),
            Text('Pas de connexion! Veuillez verifier'),
            Text('votre connexion et actualiser .'),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoadingScreen()));
              },
              child: Padding(
                padding:  EdgeInsets.only(top: size.height*0.15),
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset('assets/images/refresh.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
