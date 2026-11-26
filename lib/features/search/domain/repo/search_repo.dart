import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/shared/domain/entites/keyword.dart';
import 'package:movify/shared/domain/entites/media_item.dart';
import 'package:movify/shared/domain/entites/person_item.dart';

abstract interface class SearchRepo {
  /// Mixed movies and series (`search/multi`).
  Future<Either<Failure, PageResult<MediaItem>>> searchMulti({
    required String query,
    int page = 1,
  });

  /// Movies only (`search/movie`).
  Future<Either<Failure, PageResult<MediaItem>>> searchMovies({
    required String query,
    int page = 1,
  });

  /// Series only (`search/tv`).
  Future<Either<Failure, PageResult<MediaItem>>> searchSeries({
    required String query,
    int page = 1,
  });

  /// Actors and crew (`search/person`).
  Future<Either<Failure, PageResult<PersonItem>>> searchPeople({
    required String query,
    int page = 1,
  });

  /// Keywords (`search/keyword`).
  Future<Either<Failure, PageResult<Keyword>>> searchKeywords({
    required String query,
    int page = 1,
  });
}
