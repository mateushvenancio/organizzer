import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? errorText;

  const MainTextField({
    super.key,
    this.hint,
    this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
      ),
    );
  }
}
