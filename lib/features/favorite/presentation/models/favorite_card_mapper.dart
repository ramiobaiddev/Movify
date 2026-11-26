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
