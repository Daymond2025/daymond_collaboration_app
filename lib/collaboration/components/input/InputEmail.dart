// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';


class InputEmail extends StatefulWidget {
  InputEmail({Key? key, required this.EmailController, required this.Label})
      : super(key: key);
  TextEditingController EmailController = TextEditingController();
  String Label = '';
  @override
  State<InputEmail> createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: const Offset(0, 0.5),
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.EmailController,
        //autofillHints: const [AutofillHints.email],
        //onEditingComplete: () => TextInput.finishAutofillContext(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          border: InputBorder.none,
          labelText: widget.Label,
        ),
      ),
    );
  }

  bool validateEmail(String value) {
    RegExp regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return (!regex.hasMatch(value)) ? false : true;
  }
}


