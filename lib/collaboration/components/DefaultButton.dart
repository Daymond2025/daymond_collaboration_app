// ignore_for_file: file_names, prefer_const_constructors
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    this.press,
    this.couleur,
  }) : super(key: key);
  final String text;
  final Function? press;
  final Color? couleur;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 48,
      child: GestureDetector(
        onTap: press as void Function()?,
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(6),
           decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff880068),
                  primary
                ],
              ),
               borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: TextStyle(fontSize: (18), color: Colors.white,),textAlign: TextAlign.center,),
          ),
        ),
      ),
    );
  }
}
