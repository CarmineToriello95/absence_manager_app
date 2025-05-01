import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool isSameOrAfter(DateTime dateToCompareWith) {
    final dateToCompareWithFormatted = DateTime(
        dateToCompareWith.year, dateToCompareWith.month, dateToCompareWith.day);
    return isAtSameMomentAs(dateToCompareWithFormatted) ||
        isAfter(dateToCompareWithFormatted);
  }

  bool isSameOrBefore(DateTime dateToCompareWith) {
    final dateToCompareWithFormatted = DateTime(
        dateToCompareWith.year, dateToCompareWith.month, dateToCompareWith.day);
    return isAtSameMomentAs(dateToCompareWithFormatted) ||
        isBefore(dateToCompareWithFormatted);
  }

  String get formatToYYYYmmdd => DateFormat('yyyy-MM-dd').format(this);
}
