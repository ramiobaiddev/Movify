import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/home/data/models/movie_model.dart';
import 'package:movify/features/home/data/models/series_model.dart';
import 'package:movify/features/search/data/models/keyword_model.dart';
import 'package:movify/features/search/data/models/person_item_model.dart';
import 'package:movify/shared/data/models/media_item_model.dart';

abstract interface class RemoteSearchDataSource {
  Future<PageResult<MediaItemModel>> searchMulti({
    required String query,
    int page = 1,
  });

  Future<PageResult<MovieModel>> searchMovies({
    required String query,
    int page = 1,
  });

  Future<PageResult<SeriesModel>> searchSeries({
    required String query,
    int page = 1,
  });

  Future<PageResult<PersonItemModel>> searchPeople({
    required String query,
    int page = 1,
  });

  Future<PageResult<KeywordModel>> searchKeywords({
    required String query,
    int page = 1,
  });
}
