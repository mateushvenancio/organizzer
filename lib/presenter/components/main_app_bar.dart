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
  final List<Widget>? menuItems;

  const MainAppBar({super.key, this.title, this.leading, this.menuItems});

  Widget buildLeading(bool canPop, Function() onBack) {
    if (canPop) {
      return MainIconButton.back(onTap: () => onBack());
    }
    return LogoComponent(size: 24);
  }

  Widget get buildMenu {
    // if (menuItems == null) return Container();
    // if (menuItems?.isEmpty ?? true) return Container();

    // return IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: menuItems ?? [],
    );
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
            buildMenu,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MainAppBarItem extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MainAppBarItem({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(icon, color: AppColors.primaryColor),
      ),
    );
  }
}
