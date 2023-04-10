import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/components/main_text_field.dart';
import 'package:organizzer/presenter/components/primary_button.dart';
import 'package:organizzer/resources/constants.dart';
import 'package:organizzer/utils/launch_whatsapp.dart';

class WhatsappScreen extends StatefulWidget {
  const WhatsappScreen({super.key});

  @override
  State<WhatsappScreen> createState() => _WhatsappScreenState();
}

class _WhatsappScreenState extends State<WhatsappScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'WhatsApp Launcher'),
      body: Container(
        padding: const EdgeInsets.all(kMainPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainTextField(
              controller: textController,
              hint: '(38) 9 9883-7290',
              label: 'Número de telefone',
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: kMainPadding),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onTap: () async {
                  try {
                    await launchWhatsapp(textController.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                text: 'Launch',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
