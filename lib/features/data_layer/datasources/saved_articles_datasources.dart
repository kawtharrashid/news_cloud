import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_cloud/core/errors/exceptions.dart';

class SavedArticlesDataSource {
  final Box<Map> _savedArticlesBox;

  SavedArticlesDataSource({
    required Box<Map> savedArticlesBox,
  }) : _savedArticlesBox = savedArticlesBox;

  Future<void> saveArticle({
    required String articleURL,
    required Map<String, dynamic> article,
  }) async {
    try {
      await _savedArticlesBox.put(articleURL, article);
      log('Article saved successfully: $article');
    } catch (error) {
      throw const UnknownException(
        message: 'Unable to save the article.',
      );
    }
  }

  Future<void> removeArticle({
    required String articleURL,
  }) async {
    try {
      await _savedArticlesBox.delete(articleURL);
    } catch (error) {
      throw const UnknownException(
        message: 'Unable to remove the saved article.',
      );
    }
  }

  Future<List<Map<String, dynamic>>> getSavedArticles() async {
    try {
      return _savedArticlesBox.values
          .map((article) => Map<String, dynamic>.from(article))
          .toList();
    } catch (error) {
      throw const UnknownException(
        message: 'Unable to retrieve saved articles.',
      );
    }
  }
}
