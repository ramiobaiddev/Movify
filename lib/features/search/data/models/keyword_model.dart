import 'package:movify/shared/domain/entites/keyword.dart';

class KeywordModel {
  const KeywordModel({required this.id, required this.name});

  final int id;
  final String name;

  factory KeywordModel.fromJson(Map<String, dynamic> json) => KeywordModel(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String? ?? '',
  );

  Keyword toEntity() => Keyword(id: id, name: name);
}
