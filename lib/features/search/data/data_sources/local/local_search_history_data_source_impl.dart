import 'package:hive/hive.dart';
import 'package:movify/core/storage/hive/hive_service.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/search/data/data_sources/local/local_search_history_data_source.dart';
import 'package:movify/features/search/data/models/search_history_model.dart';

class LocalSearchDataSourceImpl implements LocalSearchHistoryDataSource {
  @override
  Future<void> addToSearchHistory(SearchHistoryModel searchHistory) async {
    final box = await HiveService.getSearchHistoryBox();
    // Searching the same title again moves it to the top instead of
    // duplicating it. A movie and a series can share an id or a title, so the
    // pair is the identity.
    await _deleteWhere(
      box,
      searchHistory.id,
      searchHistory.historyContentType,
    );
    await box.add(searchHistory);
  }

  @override
  Future<List<SearchHistoryModel>> getSearchHistory() async {
    final box = await HiveService.getSearchHistoryBox();
    return box.values.toList().reversed.toList();
  }

  @override
  Future<void> clearSearchHistory() async {
    final box = await HiveService.getSearchHistoryBox();
    await box.clear();
  }

  @override
  Future<void> deleteFromSearchHistory(int id, ContentType type) async {
    final box = await HiveService.getSearchHistoryBox();
    await _deleteWhere(box, id, type);
  }

  Future<void> _deleteWhere(
    Box<SearchHistoryModel> box,
    int id,
    ContentType type,
  ) => box.deleteAll(
    box.keys.where((key) {
      final item = box.get(key);
      return item != null && item.id == id && item.historyContentType == type;
    }).toList(),
  );
}
