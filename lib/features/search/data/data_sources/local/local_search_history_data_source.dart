import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/search/data/models/search_history_model.dart';

abstract interface class LocalSearchHistoryDataSource {
  Future<void> addToSearchHistory(SearchHistoryModel searchHistory);
  Future<List<SearchHistoryModel>> getSearchHistory();
  Future<void> clearSearchHistory();
  Future<void> deleteFromSearchHistory(int id, ContentType type);
}
