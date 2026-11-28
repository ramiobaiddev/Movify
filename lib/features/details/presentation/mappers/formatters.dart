import 'package:intl/intl.dart';

/// Small value cleaners shared by the content mappers.

String? nonEmpty(String? value) =>
    value == null || value.trim().isEmpty ? null : value.trim();

DateTime? parseDate(String? value) =>
    value == null || value.isEmpty ? null : DateTime.tryParse(value);

/// TMDB sends 0 for "no votes"; that is not a rating.
double? ratingOrNull(double? value) =>
    value == null || value <= 0 ? null : value;

String formatDate(DateTime date) => DateFormat.yMMMd().format(date);

String formatNumber(int value) => NumberFormat.decimalPattern().format(value);

/// `2hr 42min`, `45min`; null when the runtime is unknown.
String? formatRuntime(int minutes) {
  if (minutes <= 0) {
    return null;
  }
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (hours == 0) {
    return '${rest}min';
  }
  return rest == 0 ? '${hours}hr' : '${hours}hr ${rest}min';
}
