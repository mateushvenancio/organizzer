import 'package:intl/intl.dart';

extension XNum on num {
  String toPrice() => NumberFormat.decimalPatternDigits(locale: 'pt_BR', decimalDigits: 2).format(this);
}
