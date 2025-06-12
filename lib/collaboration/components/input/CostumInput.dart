// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';


class CostumInput extends StatefulWidget {
  CostumInput({Key? key,
    required this.Controller,
    required this.Label,
    required this.Icon,
  })
      : super(key: key);
  TextEditingController Controller = TextEditingController();
  String Label = '';
  final Icon;
  @override
  State<CostumInput> createState() => _CostumInputState();
}

class _CostumInputState extends State<CostumInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
        controller: widget.Controller,
        //autofillHints: const [AutofillHints.email],
        //onEditingComplete: () => TextInput.finishAutofillContext(),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintTextDirection: TextDirection.ltr,
          hintStyle: TextStyle(),
          labelText: widget.Label,
          prefixIcon: widget.Icon,
        ),
        onChanged: (value) {},
        validator: (value) {
          if (value!.isEmpty) {
            return 'Ce champs est vide';
          }

          return null;
        },
      ),
    );
  }
}
