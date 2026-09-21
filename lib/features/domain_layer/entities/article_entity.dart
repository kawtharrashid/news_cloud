import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? image;
  final String title;
  final String? description;
  final String? content;
  final String? url;
  final DateTime? publishedAt;
  final String? sourceName;

  const ArticleEntity({
    this.image,
    required this.title,
    this.description,
    this.content,
    this.url,
    this.publishedAt,
    this.sourceName,
  });

  @override
  List<Object?> get props => [
        image,
        title,
        description,
        content,
        url,
        publishedAt,
        sourceName,
      ];
}
