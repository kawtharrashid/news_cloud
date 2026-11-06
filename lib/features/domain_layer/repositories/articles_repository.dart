import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';

abstract class ArticlesRepository {
  Future<void> saveArticle({required ArticleEntity article});
  Future<void> removeArticle({required String articleURL});
  Future<List<ArticleEntity>> getSavedArticles();
}
