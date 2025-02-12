import 'package:intl/intl.dart';

String formateDateByDMMMYYYY(DateTime date) {
  return DateFormat('d MMM, yyyy').format(date);
}
