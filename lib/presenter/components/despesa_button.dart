import 'package:flutter/material.dart';
import 'package:organizzer/resources/colors.dart';

class DespesaButton extends StatelessWidget {
  const DespesaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.red,
      ),
      child: Icon(Icons.arrow_back, color: Colors.white),
    );
  }
}
