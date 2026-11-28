import 'package:flutter/material.dart';
import 'package:movify/core/utils/enums/content_type.dart';

/// A feeling to pick a watch by. Each one stands for a few genres.
///
/// The gradients are artwork from the design, not theme colours, so they do
/// not change with the theme.
enum Mood {
  escapeReality(
    label: 'Escape Reality',
    icon: Icons.rocket_launch_rounded,
    from: Color(0xFF00B4DB),
    to: Color(0xFF0083B0),
    movieGenres: {14, 878, 12},
    tvGenres: {10765, 10759},
  ),
  laughOutLoud(
    label: 'Laugh Out Loud',
    icon: Icons.sentiment_very_satisfied_rounded,
    from: Color(0xFFF7971E),
    to: Color(0xFFFFD200),
    dark: true,
    movieGenres: {35},
    tvGenres: {35},
  ),
  solveTheMystery(
    label: 'Solve the Mystery',
    icon: Icons.manage_search_rounded,
    from: Color(0xFF654EA3),
    to: Color(0xFFEAAFC8),
    movieGenres: {9648, 80},
    tvGenres: {9648, 80},
  ),
  thoughtProvoking(
    label: 'Thought Provoking',
    icon: Icons.psychology_rounded,
    from: Color(0xFF0F2027),
    to: Color(0xFF2C5364),
    movieGenres: {18, 99},
    tvGenres: {18, 99},
  ),
  adrenalineRush(
    label: 'Adrenaline Rush',
    icon: Icons.local_fire_department_rounded,
    from: Color(0xFFED213A),
    to: Color(0xFF93291E),
    movieGenres: {28, 53},
    tvGenres: {10759, 80},
  ),
  familyTime(
    label: 'Family Time',
    icon: Icons.family_restroom_rounded,
    from: Color(0xFF56AB2F),
    to: Color(0xFFA8E063),
    dark: true,
    movieGenres: {10751, 16},
    tvGenres: {10751, 16, 10762},
  );

  const Mood({
    required this.label,
    required this.icon,
    required this.from,
    required this.to,
    required this.movieGenres,
    required this.tvGenres,
    this.dark = false,
  });

  final String label;
  final IconData icon;
  final Color from;
  final Color to;

  /// True when the gradient is light and the label needs dark ink.
  final bool dark;
  final Set<int> movieGenres;
  final Set<int> tvGenres;

  /// TMDB genre ids for [kind] (movie and tv ids differ).
  Set<int> genresFor(ContentType kind) =>
      kind == ContentType.movies ? movieGenres : tvGenres;
}
