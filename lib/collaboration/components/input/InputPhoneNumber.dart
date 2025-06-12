// ignore_for_file: non_constant_identifier_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InputPhoneNumber extends StatefulWidget {
  InputPhoneNumber(
      {Key? key,
      required this.PhoneNumberController,
      required this.Label,
      this.icon})
      : super(key: key);

  TextEditingController PhoneNumberController = TextEditingController();
  final Label;
  final icon;

  @override
  State<InputPhoneNumber> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  var textInputType =
      const TextInputType.numberWithOptions(signed: true, decimal: true);
  TextEditingController PhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //alignment: Alignment.center,
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
      child: Stack(
        children: [
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              // print(number.phoneNumber);
              widget.PhoneNumberController.text = number.phoneNumber.toString();
            },
            onInputValidated: (bool value) {
              // print(value);
            },
            // ignore: prefer_const_constructors
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
            locale: 'FR',
            initialValue: PhoneNumber(isoCode: 'CI'),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: const TextStyle(color: Colors.black),
            textFieldController: PhoneNumberController,
            formatInput: false,
            // ignore: prefer_const_constructors
            inputDecoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 14),
              border: InputBorder.none,
              labelText: widget.Label, //'Numéro de téléphone',
              suffixIcon: widget.icon,
            ),
            keyboardType: textInputType,
            inputBorder: const OutlineInputBorder(),
            onSaved: (PhoneNumber number) {
              setState(() {
                //widget.PhoneNumberController.text =number.dialCode.toString()+PhoneNumberController.text;
                widget.PhoneNumberController.text =
                    number.dialCode.toString() + PhoneNumberController.text;
                //  print(widget.PhoneNumberController);
              });
            },
          ),
        ],
      ),
    );
  }
}
