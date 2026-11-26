import 'package:equatable/equatable.dart';
import 'package:movify/shared/domain/entites/media_item.dart';

/// A person's profile and the movies and series they appear in, most popular
/// first.
class PersonDetails extends Equatable {
  const PersonDetails({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.placeOfBirth,
    required this.knownForDepartment,
    required this.movies,
    required this.series,
  });

  final int id;
  final String name;
  final String? profilePath;
  final String biography;
  final DateTime? birthday;
  final DateTime? deathday;
  final String placeOfBirth;
  final String knownForDepartment;
  final List<MediaItem> movies;
  final List<MediaItem> series;

  int get creditCount => movies.length + series.length;

  /// Age today, or age at death. Null without a birthday.
  int? ageAt(DateTime today) {
    final born = birthday;
    if (born == null) {
      return null;
    }
    final end = deathday ?? today;
    var age = end.year - born.year;
    final hadBirthday =
        end.month > born.month ||
        (end.month == born.month && end.day >= born.day);
    if (!hadBirthday) {
      age--;
    }
    return age;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    profilePath,
    biography,
    birthday,
    deathday,
    placeOfBirth,
    knownForDepartment,
    movies,
    series,
  ];
}
