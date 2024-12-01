import 'package:intl/intl.dart';

String formatDate(String date) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return formattedDate;
  } catch (e) {
    return 'Invalid date format';
  }
}
