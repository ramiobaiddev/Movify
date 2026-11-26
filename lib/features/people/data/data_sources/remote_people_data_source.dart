import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/people/data/models/person_details_model.dart';
import 'package:movify/shared/data/models/person_item_model.dart';

abstract interface class RemotePeopleDataSource {
  Future<PageResult<PersonItemModel>> popular({int page = 1});

  Future<PersonDetailsModel> details(int id);
}
