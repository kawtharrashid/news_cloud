import '../../domain_layer/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    super.image,
    required super.title,
    super.description,
    super.content,
    super.url,
    super.publishedAt,
    super.sourceName,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final source = json['source'];
    final sourceName = source is Map ? source['name']?.toString() : null;

    return ArticleModel(
      image: json['urlToImage']?.toString(),
      title: (json['title'] ?? 'No Title Available').toString(),
      description: json['description']?.toString(),
      content: json['content']?.toString(),
      url: json['url']?.toString(),
      publishedAt: json['publishedAt'] != null &&
              json['publishedAt'].toString().isNotEmpty
          ? DateTime.tryParse(json['publishedAt'].toString())
          : null,
      sourceName: sourceName,
    );
  }
}
