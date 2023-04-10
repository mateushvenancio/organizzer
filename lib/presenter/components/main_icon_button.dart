import 'package:flutter/material.dart';
import 'package:organizzer/resources/colors.dart';

class MainIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;

  const MainIconButton({super.key, this.onTap, required this.icon});

  const MainIconButton.back({super.key, this.onTap}) : icon = Icons.arrow_back;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primaryColor,
      child: IconButton(
        color: Colors.white,
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        constraints: BoxConstraints(
          minHeight: 24,
          minWidth: 24,
        ),
      ),
    );
  }
}
