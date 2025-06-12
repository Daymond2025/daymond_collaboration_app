import 'dart:async';

import 'package:daymond_collaboration_app/collaboration/components/skeletonLaoding.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/check_network_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
class DetailsNotificationScreen extends StatefulWidget {
  const DetailsNotificationScreen({super.key,
    required this.text,
    required this.image,
    required this.id,
    required this.date,
    required this.type,
  });
  final id;
  final text;
  final image;
  final date;
  final type;
  @override
  State<DetailsNotificationScreen> createState() => _DetailsNotificationScreenState();
}

class _DetailsNotificationScreenState extends State<DetailsNotificationScreen> {
  bool laoding = true;
  void LaodFile(){
    new Timer(const Duration(seconds: 1), () async {
      setState(() {
        laoding = false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LaodFile();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: grid,
      appBar: AppBar(
        elevation: 2,
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        title: Padding(
          padding:  EdgeInsets.only(right: size.width*0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/regidaymond.png',width: 30,),
              Text('${widget.type}'.toUpperCase(),style: TextStyle(fontSize: 16,color: black),)
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.delete)
          ),
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if(!connected)
            return CheckNetworkScreen();
          return ShimmerLoading(
            isLoading: isLaoding,
            contentView: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('${widget.text}',style: TextStyle(fontSize: 18,color: black,),textAlign: TextAlign.start,),
                        ),
                        widget.image == '0' ? Container()
                            :
                        Image.network('${notifPath}/${widget.image}',fit: BoxFit.cover,height: size.height/2,),
                        Padding(
                          padding:  EdgeInsets.only(right: 12,top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${widget.date}'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
    );
  }
}
