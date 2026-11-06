// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/domain_layer/repositories/articles_repository.dart';

part 'saved_news_state.dart';

class SavedNewsCubit extends Cubit<SavedNewsState> {
  final ArticlesRepository repository;
  SavedNewsCubit({
    required this.repository,
  }) : super(SavedNewsCubitInitial());

  // SavedNewsCubit({required this.repository}) : super(SavedNewsCubitInitial());

  Future<void> saveArticle({required ArticleEntity article}) async {
    emit(SavedNewsCubitLoading());
    try {
      await repository.saveArticle(article: article);
      await loadSavedArticles();
    } catch (error) {
      emit(SavedNewsCubitError(message: error.toString()));
    }
  }

  Future<void> loadSavedArticles() async {
    emit(SavedNewsCubitLoading());
    try {
      final savedArticles = await repository.getSavedArticles();
      emit(SavedNewsCubitLoaded(savedArticles: savedArticles));
    } catch (error) {
      emit(SavedNewsCubitError(message: error.toString()));
    }
  }

  Future<void> removeArticle({required String articleURL}) async {
    emit(SavedNewsCubitLoading());
    try {
      await repository.removeArticle(articleURL: articleURL);
      await loadSavedArticles();
    } catch (error) {
      emit(SavedNewsCubitError(message: error.toString()));
    }
  }
}
