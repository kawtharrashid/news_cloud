import 'package:equatable/equatable.dart';

import '../../../domain_layer/entities/article_entity.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

final class NewsInitial extends NewsState {
  const NewsInitial();
}

final class NewsLoading extends NewsState {
  const NewsLoading();
}

final class NewsLoaded extends NewsState {
  final List<ArticleEntity> articles;

  const NewsLoaded({required this.articles});

  @override
  List<Object?> get props => [articles];
}

final class NewsError extends NewsState {
  final String message;

  const NewsError({required this.message});

  @override
  List<Object?> get props => [message];
}
