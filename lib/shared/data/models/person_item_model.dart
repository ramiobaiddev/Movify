import 'package:movify/shared/domain/entites/person_item.dart';

class PersonItemModel {
  const PersonItemModel({
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

  factory PersonItemModel.fromJson(Map<String, dynamic> json) {
    final knownList =
        (json['known_for'] as List?)
            ?.map((e) {
              final m = e as Map<String, dynamic>;
              return (m['title'] ?? m['name']) as String?;
            })
            .whereType<String>()
            .toList() ??
        const [];

    return PersonItemModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
      knownForDepartment: json['known_for_department'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      knownFor: knownList,
    );
  }

  /// Null when the person has no photo: a list of faces with holes is worse
  /// than a shorter list.
  static PersonItemModel? tryFromJson(Map<String, dynamic> json) {
    final person = PersonItemModel.fromJson(json);
    return person.profilePath == null ? null : person;
  }

  PersonItem toEntity() => PersonItem(
    id: id,
    name: name,
    profilePath: profilePath,
    knownForDepartment: knownForDepartment,
    popularity: popularity,
    knownFor: knownFor,
  );
}
