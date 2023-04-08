import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organizzer/resources/colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const MainAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryVariant,
      statusBarIconBrightness: Brightness.light,
    ));

    return AppBar(
      backgroundColor: AppColors.greyBackground,
      title: Text(
        title ?? '',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
