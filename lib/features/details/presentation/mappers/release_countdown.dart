import 'package:intl/intl.dart';

/// `today`, `tomorrow`, `in 12 days`.
String daysUntil(DateTime date, DateTime today) {
  final days = DateTime(
    date.year,
    date.month,
    date.day,
  ).difference(DateTime(today.year, today.month, today.day)).inDays;

  return switch (days) {
    <= 0 => 'today',
    1 => 'tomorrow',
    _ => 'in $days days',
  };
}

/// `Releases Wed, Nov 25 · in 12 days`, `... · tomorrow`, `... · today`.
String releaseCountdown(DateTime release, DateTime today) =>
    'Releases ${DateFormat('EEE, MMM d').format(release)} · '
    '${daysUntil(release, today)}';
