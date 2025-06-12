// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../const/color.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: shadow,
          ),
          child: child,
        ),

        // Image.asset('assets/images/Rectangle 3.png')
      ],
    );
  }
}
