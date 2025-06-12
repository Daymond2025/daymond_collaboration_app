import 'package:flutter/material.dart';

class Contact2TextField extends StatefulWidget {
  Contact2TextField({Key? key,
    required this.Controller,
    required this.Label,
    this.Icon
  })
      : super(key: key);
  TextEditingController Controller = TextEditingController();
  final Label;
  final Icon;

  @override
  State<Contact2TextField> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<Contact2TextField> {
  var textInputType = const TextInputType.numberWithOptions(signed: true, decimal: true);
  TextEditingController PhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintTextDirection: TextDirection.ltr,
          hintStyle: TextStyle(),
          labelText: widget.Label,
          prefixIcon: widget.Icon,
        ),
        onChanged: (value) {},
      ),
    );
  }
}
