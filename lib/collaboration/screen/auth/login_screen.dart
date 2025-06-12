// ignore_for_file: file_names, prefer_interpolation_to_compose_strings
import 'package:daymond_collaboration_app/collaboration/components/auth/login/loginForm.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        //iconTheme: const IconThemeData(color: primary),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.18),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage('assets/images/daymond_logo.png'),
                        fit: BoxFit.contain),
                    // borderRadius: BorderRadius.circular(radius)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                  child: Text(
                    'Se Connecter'.toUpperCase(),
                    style:
                        TextStyle(color: primary, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 50, right: 10, left: 10, bottom: 10),
            child: Column(
              children: [
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
