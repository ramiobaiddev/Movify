import 'package:dartz/dartz.dart';
import 'package:movify/core/domain/use_cases/use_case.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/search/domain/repo/search_repo.dart';
import 'package:movify/shared/domain/entites/movie_entity.dart';

class SearchMovieUseCase implements UseCase<PageResult<MovieEntity>, String> {
  final SearchRepo searchRepo;

  const SearchMovieUseCase({required this.searchRepo});
  @override
  Future<Either<Failure, PageResult<MovieEntity>>> call([String? parameter]) =>
      searchRepo.searchMovies(query: parameter!);
}
