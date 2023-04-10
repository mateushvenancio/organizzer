import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class YesNoDialog extends StatelessWidget {
  final String title;
  final Function() onYes;
  const YesNoDialog({super.key, required this.title, required this.onYes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text('Não')),
        TextButton(
          onPressed: () {
            onYes();
            context.pop();
          },
          child: Text('Sim'),
        ),
      ],
    );
  }
}
