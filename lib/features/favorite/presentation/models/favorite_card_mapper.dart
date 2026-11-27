import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

extension FavoriteToCardDisplay on FavoriteEntity {
  /// Lets a favorite reuse the shared year label and details navigation.
  CardDisplayModel toCardDisplay() => CardDisplayModel(
    id: specificId,
    title: title,
    posterPath: posterImage,
    backdropPath: backdropImage,
    rating: rating,
    genreIds: genres,
    date: date,
    contentType: contentType,
  );
}

extension CardDisplayToFavorite on CardDisplayModel {
  /// What a poster's heart icon saves.
  FavoriteEntity toFavorite() => FavoriteEntity(
    specificId: id,
    tmbdId: id,
    title: title,
    posterImage: posterPath,
    backdropImage: backdropPath ?? posterPath,
    contentType: contentType,
    date: date ?? '',
    rating: rating ?? 0,
    genres: genreIds ?? const [],
  );
}
