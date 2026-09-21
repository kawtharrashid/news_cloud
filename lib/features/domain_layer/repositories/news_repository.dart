import '../entities/article_entity.dart';

abstract class NewsRepository {
  Future<List<ArticleEntity>> getTopHeadlines({required String category});
  Future<List<ArticleEntity>> searchArticles({required String query});
}
