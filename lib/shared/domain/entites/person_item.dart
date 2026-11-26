import 'package:equatable/equatable.dart';

/// One person (actor, director, crew) in search results or popular people lists.
class PersonItem extends Equatable {
  const PersonItem({
    required this.id,
    required this.name,
    this.profilePath,
    this.knownForDepartment,
    this.popularity,
    this.knownFor = const [],
  });

  final int id;
  final String name;
  final String? profilePath;
  final String? knownForDepartment;
  final double? popularity;
  final List<String> knownFor;

  @override
  List<Object?> get props => [
    id,
    name,
    profilePath,
    knownForDepartment,
    popularity,
    knownFor,
  ];
}
