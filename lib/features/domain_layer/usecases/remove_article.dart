import 'package:news_cloud/features/domain_layer/repositories/articles_repository.dart';

class RemoveArticle {
  final ArticlesRepository repository;

  RemoveArticle({required this.repository});

  Future<void> call({required String articleURL}) async {
    await repository.removeArticle(articleURL: articleURL);
  }
}
