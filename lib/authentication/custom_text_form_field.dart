import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  String? Function(String?) validator;
  TextInputType keyboardType;
  bool obscureText;
  void Function(String)? onChange;
  CustomTextFormField({
    required this.label,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChange
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            label: Text(label , style: Theme.of(context).textTheme.titleMedium,),),
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChange,
      ),
    );
  }
}
