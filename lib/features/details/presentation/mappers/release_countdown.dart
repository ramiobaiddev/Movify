import 'package:intl/intl.dart';

/// `Releases Wed, Nov 25 · in 12 days`, `... · tomorrow`, `... · today`.
String releaseCountdown(DateTime release, DateTime today) {
  final days = DateTime(
    release.year,
    release.month,
    release.day,
  ).difference(DateTime(today.year, today.month, today.day)).inDays;
  final when = switch (days) {
    <= 0 => 'today',
    1 => 'tomorrow',
    _ => 'in $days days',
  };
  return 'Releases ${DateFormat('EEE, MMM d').format(release)} · $when';
}
