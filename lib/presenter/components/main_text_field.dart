import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final String? errorText;
  final TextInputType? inputType;

  const MainTextField({
    super.key,
    this.hint,
    this.label,
    this.controller,
    this.errorText,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        labelText: label,
      ),
      keyboardType: inputType,
    );
  }
}
