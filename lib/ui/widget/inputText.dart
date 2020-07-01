import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function validator;

  InputText({this.hintText, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[200]
      ),
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
    );
  }
}
