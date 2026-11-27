import 'package:movify/shared/presentation/models/card_display_model.dart';

/// What the person credits screen is opened with (GoRouter `extra`).
class PersonCreditsArgs {
  const PersonCreditsArgs({required this.title, required this.items});

  final String title;
  final List<CardDisplayModel> items;
}
