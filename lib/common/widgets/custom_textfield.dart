import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextFiled(
      {Key? key, required this.controller, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      validator: ((value) {
        if (value!.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      }),
    );
  }
}
