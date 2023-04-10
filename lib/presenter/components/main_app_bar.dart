import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:organizzer/presenter/components/logo_component.dart';
import 'package:organizzer/presenter/components/main_icon_button.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:organizzer/resources/constants.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final bool _back;

  const MainAppBar({super.key, this.title, this.leading}) : _back = false;
  const MainAppBar.back({super.key, this.title, this.leading}) : _back = true;

  Widget buildLeading(bool canPop, Function() onBack) {
    if (canPop) {
      return MainIconButton.back(onTap: () => onBack());
    }
    return LogoComponent(size: 24);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryVariant,
      statusBarIconBrightness: Brightness.light,
    ));

    return SafeArea(
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: kMainPadding,
        ),
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(
        //       width: 1,
        //       color: AppColors.primaryColor,
        //     ),
        //   ),
        // ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildLeading(context.canPop(), () => context.pop()),
            const SizedBox(width: kMainPadding / 2),
            Expanded(
              child: Text(
                title ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
