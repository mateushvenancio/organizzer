import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/no_content_chip.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:organizzer/resources/constants.dart';

class MainCardComponent extends StatelessWidget {
  final String title;
  final List<Widget> itens;
  final Function()? menu;
  final Function()? verMais;

  const MainCardComponent({
    super.key,
    required this.title,
    this.itens = const [],
    this.menu,
    this.verMais,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: kMainElevation,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(kMainPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => menu?.call(),
                    child: Icon(Icons.more_horiz),
                  ),
                ],
              ),
              Divider(
                height: 24,
                thickness: 1,
              ),
              if (itens.isEmpty) NoContentChip(),
              ...itens,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => verMais?.call(),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: kMainPadding),
                  child: Text(
                    'Ver mais',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
