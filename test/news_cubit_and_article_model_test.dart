import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_cloud/core/errors/failure.dart';
import 'package:news_cloud/features/data_layer/models/article_model.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/domain_layer/repositories/news_repository.dart';
import 'package:news_cloud/features/domain_layer/usecases/get_top_headlines_usecase.dart';
import 'package:news_cloud/features/domain_layer/usecases/search_articles_usecase.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_cubit.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_state.dart';

class FakeNewsRepository implements NewsRepository {
  List<ArticleEntity> articles = const [];

  Failure? failure;
  Exception? exception;

  String? lastCategory;
  String? lastQuery;

  @override
  Future<List<ArticleEntity>> getTopHeadlines({
    required String category,
  }) async {
    lastCategory = category;
    if (failure != null) {
      throw failure!;
    }
    if (exception != null) {
      throw exception!;
    }
    return articles;
  }

  @override
  Future<List<ArticleEntity>> searchArticles({
    required String query,
  }) async {
    lastQuery = query;
    if (failure != null) {
      throw failure!;
    }
    if (exception != null) {
      throw exception!;
    }
    return articles;
  }
}

void main() {
  group('ArticleModel', () {
    test('parses a valid article JSON correctly', () {
      final model = ArticleModel.fromJson(const {
        'urlToImage': 'https://example.com/image.jpg',
        'title': 'Flutter News',
        'description': 'A Flutter article.',
        'content': 'Full article content.',
        'url': 'https://example.com/article',
        'publishedAt': '2026-09-04T15:30:00Z',
        'source': {
          'name': 'Example News',
        },
      });

      expect(model.image, 'https://example.com/image.jpg');
      expect(model.title, 'Flutter News');
      expect(model.description, 'A Flutter article.');
      expect(model.content, 'Full article content.');
      expect(model.url, 'https://example.com/article');
      expect(model.sourceName, 'Example News');

      expect(model.publishedAt, isNotNull);
      expect(model.publishedAt!.year, 2026);
      expect(model.publishedAt!.month, 9);
      expect(model.publishedAt!.day, 4);
    });

    test('returns null for an invalid publication date', () {
      final model = ArticleModel.fromJson(const {
        'title': 'Invalid Date',
        'publishedAt': 'not-a-date',
      });

      expect(model.publishedAt, isNull);
    });

    test('uses the default title when title is missing', () {
      final model = ArticleModel.fromJson(const {});

      expect(model.title, 'No Title Available');
    });
  });

  group('NewsCubit', () {
    late FakeNewsRepository repository;

    setUp(() {
      repository = FakeNewsRepository();
    });

    NewsCubit buildCubit() {
      return NewsCubit(
        getTopHeadlines: GetTopHeadlines(repository: repository),
        searchArticles: SearchArticles(repository: repository),
      );
    }

    blocTest<NewsCubit, NewsState>(
      'emits loading then loaded when headlines load successfully',
      build: () {
        repository.articles = const [
          ArticleEntity(title: 'Flutter News'),
        ];
        return buildCubit();
      },
      act: (cubit) => cubit.loadGeneralNews(),
      expect: () => [
        const NewsLoading(),
        isA<NewsLoaded>()
            .having((s) => s.articles.length, 'articles.length', 1)
            .having(
              (s) => s.articles.first.title,
              'articles.first.title',
              'Flutter News',
            ),
      ],
      verify: (_) {
        expect(repository.lastCategory, 'general');
      },
    );

    blocTest<NewsCubit, NewsState>(
      'emits NewsError when repository throws a Failure',
      build: () {
        repository.failure = const NetworkFailure('No internet connection');
        return buildCubit();
      },
      act: (cubit) => cubit.loadGeneralNews(),
      expect: () => [
        const NewsLoading(),
        const NewsError(message: 'No internet connection'),
      ],
    );

    blocTest<NewsCubit, NewsState>(
      'emits a generic NewsError for an unexpected exception',
      build: () {
        repository.exception = Exception('Unexpected error');
        return buildCubit();
      },
      act: (cubit) => cubit.loadGeneralNews(),
      expect: () => [
        const NewsLoading(),
        const NewsError(message: 'Something went wrong'),
      ],
    );

    blocTest<NewsCubit, NewsState>(
      'searchNews sends the query to the repository',
      build: () {
        repository.articles = const [
          ArticleEntity(title: 'Apple News'),
        ];
        return buildCubit();
      },
      act: (cubit) => cubit.searchNews(query: 'Apple'),
      expect: () => [
        const NewsLoading(),
        isA<NewsLoaded>().having(
          (s) => s.articles.first.title,
          'articles.first.title',
          'Apple News',
        ),
      ],
      verify: (_) {
        expect(repository.lastQuery, 'Apple');
      },
    );
  });
}
