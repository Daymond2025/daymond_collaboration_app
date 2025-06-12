import 'package:daymond_collaboration_app/collaboration/components/auth/signup/RegisterForm.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final List<CityModel> cities;
  const RegisterScreen({super.key, required this.cities});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                    'Créer un compte'.toUpperCase(),
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
                const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
            child: Column(
              children: [
                RegisterForm(
                  cities: widget.cities,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
