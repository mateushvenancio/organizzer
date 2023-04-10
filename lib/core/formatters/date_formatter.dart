import 'package:intl/intl.dart';

class DateFormatter {
  String miniDate(DateTime value) {
    final formatter = DateFormat('MMM d');
    return formatter.format(value);
  }
}
