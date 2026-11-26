import 'package:movify/core/network/api/services/api_service.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/people/data/data_sources/remote_people_data_source.dart';
import 'package:movify/features/people/data/models/person_details_model.dart';
import 'package:movify/shared/data/mappers/map_paged_response.dart';
import 'package:movify/shared/data/models/person_item_model.dart';

class RemotePeopleDataSourceImpl implements RemotePeopleDataSource {
  const RemotePeopleDataSourceImpl({required this.apiService});

  final ApiService apiService;

  @override
  Future<PageResult<PersonItemModel>> popular({int page = 1}) async =>
      mapPagedItems(
        data: await apiService.tmdb.people.popular(page: page),
        parse: PersonItemModel.tryFromJson,
      );

  @override
  Future<PersonDetailsModel> details(int id) async =>
      PersonDetailsModel.fromJson(await apiService.tmdb.people.details(id));
}
