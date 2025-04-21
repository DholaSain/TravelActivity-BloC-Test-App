import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toTimeOnly() {
    return DateFormat.Hm().format(this);
  }

  String toReadableDate() {
    return DateFormat('d MMMM y').format(this);
  }
}
