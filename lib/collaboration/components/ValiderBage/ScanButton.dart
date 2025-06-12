// ignore_for_file: file_names, prefer_const_constructors
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width*0.4,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          // primary: Colors.white,
          backgroundColor: blue,
        ),
        onPressed: press as void Function()?,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: (18),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
