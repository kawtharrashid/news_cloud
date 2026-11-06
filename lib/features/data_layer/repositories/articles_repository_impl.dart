import 'package:news_cloud/core/errors/error_mapper.dart';
import 'package:news_cloud/core/errors/exceptions.dart';
import 'package:news_cloud/features/data_layer/datasources/saved_articles_datasources.dart';
import 'package:news_cloud/features/data_layer/models/article_model.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/domain_layer/repositories/articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final SavedArticlesDataSource savedArticlesDataSource;
  ArticlesRepositoryImpl({
    required this.savedArticlesDataSource,
  });

  @override
  Future<void> saveArticle({required ArticleEntity article}) async {
    try {
      final articleURL = article.url;
      if (articleURL == null || articleURL.isEmpty) {
        throw const UnknownException(
          message: 'Unable to save this article',
        );
      }

      await savedArticlesDataSource.saveArticle(
        articleURL: articleURL,
        article: ArticleModel.fromEntity(article).toJson(),
      );
    } on AppException catch (error) {
      throw ErrorMapper.toFailure(error);
    }
  }

  @override
  Future<void> removeArticle({required String articleURL}) async {
    try {
      await savedArticlesDataSource.removeArticle(
        articleURL: articleURL,
      );
    } on AppException catch (error) {
      throw ErrorMapper.toFailure(error);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    try {
      return (await savedArticlesDataSource.getSavedArticles())
          .map((article) => ArticleModel.fromJson(article))
          .toList();
    } on AppException catch (error) {
      throw ErrorMapper.toFailure(error);
    }
  }
}
