// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:flutter/material.dart';


class InputPassword extends StatefulWidget {
  InputPassword(
      {Key? key, required this.PasswordControler, required this.Label})
      : super(key: key);
  TextEditingController PasswordControler = TextEditingController();
  String Label = "";

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool visibl = true;
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
        controller: widget.PasswordControler,
        obscureText: visibl,
        autocorrect: true,
        autofillHints: const [AutofillHints.password],
        //onEditingComplete: () => TextInput.finishAutofillContext(),
        decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(
                  visibl != true ? Icons.visibility : Icons.visibility_off,color: primary,),
                onPressed: () {
                  setState(() {
                    visibl = !visibl;
                  });
                }),
            border: InputBorder.none,
            labelText: widget.Label
        ),
        onChanged: (value) {},
        validator: (value) {
          if (value!.isEmpty) {
            return 'Entrer password';
          } else if (value.length < 6) {
            return ' le password est court';
          }
          return null;
        },
      ),
    );
  }


}
