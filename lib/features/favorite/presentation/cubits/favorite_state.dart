import 'package:equatable/equatable.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

final class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();
}

final class FavoriteLoading extends FavoriteState {
  const FavoriteLoading();
}

/// Everything the current user has saved, in no particular order (the screen
/// sorts). The heart icons and the Favorites screen both read from this list.
final class FavoriteLoaded extends FavoriteState {
  const FavoriteLoaded({required this.items, required this.currentUserId});

  final List<FavoriteEntity> items;
  final String currentUserId;

  bool get isGuest => currentUserId == 'guest';

  bool contains(int specificId, ContentType type) => items.any(
    (f) => f.specificId == specificId && f.contentType == type,
  );

  List<FavoriteEntity> ofType(ContentType type) =>
      items.where((f) => f.contentType == type).toList();

  @override
  List<Object?> get props => [items, currentUserId];
}

final class FavoriteError extends FavoriteState {
  const FavoriteError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
