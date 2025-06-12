import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:flutter/material.dart';
class AppRecruteur extends StatefulWidget {
  const AppRecruteur({Key? key}) : super(key: key);

  @override
  State<AppRecruteur> createState() => _AppRecruteurState();
}

class _AppRecruteurState extends State<AppRecruteur> {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         Padding(
           padding: const EdgeInsets.only(top: 8.0),
           child: Container(
             height: 60,
             width: 60,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(100),
               image: DecorationImage(
                 image: AssetImage('assets/images/11.png'),
                 fit: BoxFit.cover
               )
             ),
           ),
         ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Compte vendeur".toUpperCase(),style: TextStyle(color: black,fontWeight: FontWeight.bold,fontSize: 15),),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              size: 15,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.leaderboard,
              size: 15,
            ))
      ],
    );
  }
}
