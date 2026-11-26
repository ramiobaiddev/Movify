import 'package:equatable/equatable.dart';

/// TMDB search keyword tag (e.g. "superhero", "based on novel").
class Keyword extends Equatable {
  const Keyword({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
