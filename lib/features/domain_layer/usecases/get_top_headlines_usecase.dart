import 'package:news_cloud/features/domain_layer/repositories/news_repository.dart';

import '../entities/article_entity.dart';

class GetTopHeadlines {
  final NewsRepository repository;
  GetTopHeadlines({required this.repository});

  Future<List<ArticleEntity>> call({required String category}) {
    return repository.getTopHeadlines(category: category);
  }
}
