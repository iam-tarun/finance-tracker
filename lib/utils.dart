import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  DateTime date = DateTime.parse(dateString);

  String formattedDate = DateFormat('MMM d, yyyy').format(date);

  String dayWithSuffix = _addOrdinalSuffix(date.day);

  return formattedDate.replaceFirst(RegExp(r'\d+'), dayWithSuffix);
}

String _addOrdinalSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return '${day}th';
  }
  switch (day % 10) {
    case 1:
      return '${day}st';
    case 2:
      return '${day}nd';
    case 3:
      return '${day}rd';
    default:
      return '${day}th';
  }
}