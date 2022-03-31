import 'package:intl/intl.dart';

class FormatDate {
  static String formatToVNDay(String date) {
    return DateFormat('dd/MM/yyyy')
        .format(DateFormat('yyyy-MM-dd').parse(date));
  }
}
