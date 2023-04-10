import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final String? errorText;
  final TextInputType? inputType;
  final bool enabled;
  final Function()? onEnter;
  final FocusNode? focusNode;

  const MainTextField({
    super.key,
    this.hint,
    this.label,
    this.controller,
    this.errorText,
    this.inputType,
    this.enabled = true,
    this.onEnter,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        labelText: label,
      ),
      keyboardType: inputType,
      focusNode: focusNode,
      onEditingComplete: onEnter,
    );
  }
}
