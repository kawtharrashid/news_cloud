import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class SearchArticles {
  final NewsRepository repository;

  SearchArticles({required this.repository});

  Future<List<ArticleEntity>> call({required String query}) {
    return repository.searchArticles(query: query);
  }
}
