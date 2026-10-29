import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  debugPrintEndFrameBanner = false;

  final dio = Dio();
  final newsService = NewsService(dio);
  final NewsRepository repository = NewsRepositoryImpl(
    newsService: newsService,
  );

  runApp(NewsCloud(repository: repository));
}

class NewsCloud extends StatelessWidget {
  const NewsCloud({
    super.key,
    required this.repository,
  });

  final NewsRepository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<NewsRepository>.value(
      value: repository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NewsCubit>(
            create: (context) => NewsCubit(
              getTopHeadlines: GetTopHeadlines(
                repository: repository,
              ),
              searchArticles: SearchArticles(
                repository: repository,
              ),
            )..loadGeneralNews(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
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
