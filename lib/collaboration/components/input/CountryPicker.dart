// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class CountryPicker extends StatefulWidget {
  CountryPicker({Key? key, required this.countryValue}) : super(key: key);
  TextEditingController countryValue = TextEditingController();

  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  Country? selectedCountry;

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
            // Fixed: Using proper color opacity
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.countryValue,
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Pays...',
          border: InputBorder.none,
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: false,
            searchAutofocus: true,
            countryListTheme: CountryListThemeData(
              borderRadius: BorderRadius.circular(10),
              inputDecoration: InputDecoration(
                labelText: 'Rechercher',
                hintText: 'Rechercher un pays...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    // Fixed: Using proper color opacity
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            onSelect: (Country country) {
              setState(() {
                selectedCountry = country;
                widget.countryValue.text = country.name;
              });
            },
          );
        },
      ),
    );
  }
}