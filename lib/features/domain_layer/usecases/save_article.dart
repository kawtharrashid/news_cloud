import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/domain_layer/repositories/articles_repository.dart';

class SaveArticle {
  final ArticlesRepository repository;

  SaveArticle({required this.repository});

  Future<void> call({required ArticleEntity article}) async {
    await repository.saveArticle(article: article);
  }
}
