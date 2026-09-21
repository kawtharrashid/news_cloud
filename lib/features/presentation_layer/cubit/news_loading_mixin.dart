import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/core/errors/failure.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_state.dart';

mixin NewsLoadingMixin on Cubit<NewsState> {
  Future<void> loadNews(
    Future<List<ArticleEntity>> Function() request,
  ) async {
    if (state is NewsLoading) return;

    emit(const NewsLoading());

    try {
      final articles = await request();
      emit(NewsLoaded(articles: articles));
    } on Failure catch (failure) {
      emit(NewsError(message: failure.message));
    } catch (e, stackTrace) {
      log('NEWS ERROR: $e');
      log('STACK TRACE: $stackTrace');

      emit(const NewsError(message: 'Something went wrong'));
    }
  }
}
