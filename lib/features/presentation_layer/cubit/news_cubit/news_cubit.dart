import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/core/constants.dart';
import 'package:news_cloud/features/domain_layer/usecases/get_top_headlines_usecase.dart';
import 'package:news_cloud/features/domain_layer/usecases/search_articles_usecase.dart';
import '../news_loading_mixin.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> with NewsLoadingMixin {
  final GetTopHeadlines getTopHeadlines;
  final SearchArticles searchArticles;

  String _currentSearchQuery = '';
  bool _isSearchMode = false;

  NewsCubit({
    required this.getTopHeadlines,
    required this.searchArticles,
  }) : super(const NewsInitial());

  bool get isSearchActive => _isSearchMode;
  bool get isSearchingQueryIsEmpty => _currentSearchQuery.trim().isEmpty;

  Future<void> loadGeneralNews() {
    _currentSearchQuery = '';
    _isSearchMode = false;
    return loadNews(
      () => getTopHeadlines(
        category: defaultCategory,
      ),
    );
  }

  Future<void> searchNews({
    required String query,
  }) {
    _currentSearchQuery = query;
    _isSearchMode = true;
    return loadNews(
      () => searchArticles(query: query),
    );
  }
}
