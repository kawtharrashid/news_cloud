import 'package:dio/dio.dart';
import 'package:news_cloud/core/config/app_config.dart';
import 'package:news_cloud/features/data_layer/models/article_model.dart';

class NewsService {
  final Dio _dio;

  NewsService(this._dio);

  Future<List<ArticleModel>> getTopHeadlines({
    required String category,
  }) async {
    final response = await _dio.get(
      '${AppConfig.newsApiBaseUrl}/top-headlines',
      queryParameters: {
        'apiKey': AppConfig.newsApiKey,
        'country': 'us',
        'category': category,
      },
    );

    return _parseArticles(response);
  }

  Future<List<ArticleModel>> searchArticles({
    required String query,
  }) async {
    final response = await _dio.get(
      '${AppConfig.newsApiBaseUrl}/everything',
      queryParameters: {
        'apiKey': AppConfig.newsApiKey,
        'q': query,
      },
    );

    return _parseArticles(response);
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
