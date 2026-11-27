import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/extensions/main_vertical_card_extention.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

extension OpenMediaDetails on BuildContext {
  /// Opens the movie or series details screen for [item].
  void openMediaDetails(CardDisplayModel item) {
    pushNamed(
      item.contentType == ContentType.movies
          ? RouteName.movieDetail
          : RouteName.tvDetail,
      pathParameters: {'id': item.id.toString()},
      extra: item.toNavigationData(),
    );
  }
}
