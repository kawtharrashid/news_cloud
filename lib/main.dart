import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_cloud/core/constants.dart';
import 'package:news_cloud/features/data_layer/datasources/saved_articles_datasources.dart';
import 'package:news_cloud/features/data_layer/repositories/articles_repository_impl.dart';
import 'package:news_cloud/features/domain_layer/repositories/articles_repository.dart';

import 'core/config/theme/cubit/theme_cubit.dart';
import 'core/config/theme_data/app_themes.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_generator.dart';
import 'core/services/news_service.dart';
import 'features/data_layer/repositories/news_repository_impl.dart';
import 'features/domain_layer/repositories/news_repository.dart';
import 'features/domain_layer/usecases/get_top_headlines_usecase.dart';
import 'features/domain_layer/usecases/search_articles_usecase.dart';
import 'features/presentation_layer/cubit/news_cubit/news_cubit.dart';
import 'features/presentation_layer/cubit/saved_news_cubit/saved_news_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Theme
  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme(ThemeMode.system);

  // Environment
  await dotenv.load(fileName: '.env');

  // Hive
  await Hive.initFlutter();
  await Hive.openBox<Map>(kArticlesCacheBox);

  final savedArticlesBox = Hive.box<Map>(kArticlesCacheBox);

  // Dio and News API
  final dio = Dio();
  final newsService = NewsService(dio);

  // News Repository
  final NewsRepository newsRepository = NewsRepositoryImpl(
    newsService: newsService,
  );

  // Saved Articles Data Source
  final savedArticlesDataSource = SavedArticlesDataSource(
    savedArticlesBox: savedArticlesBox,
  );

  final ArticlesRepository articlesRepository = ArticlesRepositoryImpl(
    savedArticlesDataSource: savedArticlesDataSource,
  );

  debugPrintEndFrameBanner = false;

  runApp(
    NewsCloud(
      themeCubit: themeCubit,
      newsRepository: newsRepository,
      articlesRepository: articlesRepository,
    ),
  );
}

class NewsCloud extends StatelessWidget {
  const NewsCloud({
    super.key,
    required this.themeCubit,
    required this.newsRepository,
    required this.articlesRepository,
  });

  final ThemeCubit themeCubit;
  final NewsRepository newsRepository;
  final ArticlesRepository articlesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NewsRepository>.value(
          value: newsRepository,
        ),
        RepositoryProvider<ArticlesRepository>.value(
          value: articlesRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>.value(
            value: themeCubit,
          ),
          BlocProvider<NewsCubit>(
            create: (context) => NewsCubit(
              getTopHeadlines: GetTopHeadlines(
                repository: context.read<NewsRepository>(),
              ),
              searchArticles: SearchArticles(
                repository: context.read<NewsRepository>(),
              ),
            )..loadGeneralNews(),
          ),
          BlocProvider<SavedNewsCubit>(
            create: (context) => SavedNewsCubit(
              repository: context.read<ArticlesRepository>(),
            )..loadSavedArticles(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'NewsCloud',
              initialRoute: AppRoutes.home,
              onGenerateRoute: RouteGenerator.generateRoute,
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
              themeMode: themeMode,
            );
          },
        ),
      ),
    );
  }
}
