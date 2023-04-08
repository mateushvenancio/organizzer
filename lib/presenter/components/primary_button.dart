import 'package:flutter/material.dart';
import 'package:organizzer/resources/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
      ),
      child: Text(text),
    );
  }
}
