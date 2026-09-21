import 'package:dio/dio.dart';
import 'package:news_cloud/core/errors/dio_error_mapper.dart';
import 'package:news_cloud/core/errors/failure.dart';
import 'package:news_cloud/core/services/news_service.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/domain_layer/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsService newsService;

  NewsRepositoryImpl({
    required this.newsService,
  });

  @override
  Future<List<ArticleEntity>> getTopHeadlines({
    required String category,
  }) async {
    try {
      return await newsService.getTopHeadlines(
        category: category,
      );
    } on DioException catch (e) {
      throw NetworkFailure(
        DioErrorMapper.map(e),
      );
    }
  }

  @override
  Future<List<ArticleEntity>> searchArticles({
    required String query,
  }) async {
    try {
      return await newsService.searchArticles(
        query: query,
      );
    } on DioException catch (e) {
      throw NetworkFailure(
        DioErrorMapper.map(e),
      );
    }
  }
}
