import 'package:dio/dio.dart';
import 'package:news_cloud/core/config/app_config.dart';
import 'package:news_cloud/core/errors/dio_error_mapper.dart';
import 'package:news_cloud/core/errors/exceptions.dart';
import 'package:news_cloud/features/data_layer/models/article_model.dart';

class NewsService {
  final Dio _dio;

  NewsService(this._dio);

  Future<List<ArticleModel>> getTopHeadlines({
    required String category,
  }) async {
    try {
      final response = await _dio.get(
        '${AppConfig.newsApiBaseUrl}/top-headlines',
        queryParameters: {
          'apiKey': AppConfig.newsApiKey,
          'country': 'us',
          'category': category,
        },
      );

      return _parseArticles(response);
    } on DioException catch (error) {
      throw DioErrorMapper.map(error);
    } catch (error) {
      if (error is AppException) rethrow;
      throw const UnknownException(
        message: 'Unable to read the server response.',
      );
    }
  }

  Future<List<ArticleModel>> searchArticles({
    required String query,
  }) async {
    try {
      final response = await _dio.get(
        '${AppConfig.newsApiBaseUrl}/everything',
        queryParameters: {
          'apiKey': AppConfig.newsApiKey,
          'q': query,
        },
      );

      return _parseArticles(response);
    } on DioException catch (error) {
      throw DioErrorMapper.map(error);
    } catch (error) {
      if (error is AppException) rethrow;
      throw const UnknownException(
        message: 'Unable to read the server response.',
      );
    }
  }

  static List<ArticleModel> _parseArticles(Response response) {
    final data = response.data as Map<String, dynamic>;

    final articles = data['articles'] as List<dynamic>? ?? [];

    return articles
        .map(
          (article) => ArticleModel.fromJson(
            article as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
