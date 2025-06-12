import 'package:daymond_collaboration_app/collaboration/LoadingScreen.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  Get.put(ServiceCity());
  runApp(const RecruteurApp());
}

class RecruteurApp extends StatelessWidget {
  const RecruteurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Collaboration Recruteur',
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue),
    );
  }
}
