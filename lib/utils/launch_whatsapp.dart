import 'package:url_launcher/url_launcher.dart';

String _sanitizeNumber(String number) {
  final pattern = RegExp('[0-9]');
  String newNumber = '';

  for (var item in number.split('')) {
    if (pattern.hasMatch(item)) {
      newNumber += item;
    }
  }

  if (!newNumber.contains(RegExp('^55'))) {
    newNumber = '55 $newNumber';
  }

  return newNumber;
}

Future<void> launchWhatsapp(String number) async {
  final url = Uri(
    scheme: 'https',
    host: 'api.whatsapp.com',
    path: 'send',
    queryParameters: {
      'phone': _sanitizeNumber(number),
    },
  );

  await launchUrl(url, mode: LaunchMode.externalApplication);
}
