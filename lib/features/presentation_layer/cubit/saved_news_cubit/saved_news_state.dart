part of 'saved_news_cubit.dart';

sealed class SavedNewsState extends Equatable {
  const SavedNewsState();

  @override
  List<Object> get props => [];
}

final class SavedNewsCubitInitial extends SavedNewsState {}

final class SavedNewsCubitLoading extends SavedNewsState {}

final class SavedNewsCubitLoaded extends SavedNewsState {
  final List<ArticleEntity> savedArticles;

  const SavedNewsCubitLoaded({
    required this.savedArticles,
  });

  @override
  List<Object> get props => [savedArticles];
}

final class SavedNewsCubitError extends SavedNewsState {
  final String message;

  const SavedNewsCubitError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
