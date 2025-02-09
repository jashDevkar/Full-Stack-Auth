import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.validateInputField,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;

  final String? Function(String?) validateInputField;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validateInputField,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
