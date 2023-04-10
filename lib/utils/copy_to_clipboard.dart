import 'package:flutter/services.dart';

copyToClipboard(String content) async {
  await Clipboard.setData(ClipboardData(text: content));
}
