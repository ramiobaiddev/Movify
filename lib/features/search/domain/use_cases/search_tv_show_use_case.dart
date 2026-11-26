import 'package:dartz/dartz.dart';
import 'package:movify/core/domain/use_cases/use_case.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/search/domain/repo/search_repo.dart';
import 'package:movify/shared/domain/entites/series_entity.dart';

class SearchSeriesUseCase implements UseCase<PageResult<SeriesEntity>, String> {
  final SearchRepo searchRepo;

  const SearchSeriesUseCase({required this.searchRepo});
  @override
  Future<Either<Failure, PageResult<SeriesEntity>>> call([
    String? parameter,
  ]) async => searchRepo.searchSeries(query: parameter!);
}
