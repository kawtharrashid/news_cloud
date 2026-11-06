// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_cloud/features/domain_layer/repositories/articles_repository.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';

class GetSavedArticlesUseCase {
  final ArticlesRepository articleRepository;

  GetSavedArticlesUseCase(
    this.articleRepository,
  );

  Future<List<ArticleEntity>> call() async {
    return await articleRepository.getSavedArticles();
  }
}
