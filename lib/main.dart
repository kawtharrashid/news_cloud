import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_cloud/core/routes/app_routes.dart';
import 'package:news_cloud/core/routes/route_generator.dart';
import 'package:news_cloud/features/domain_layer/repositories/news_repository.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_cubit.dart';
import 'core/services/news_service.dart';
import 'features/data_layer/repositories/news_repository_impl.dart';
import 'features/domain_layer/usecases/get_top_headlines_usecase.dart';
import 'features/domain_layer/usecases/search_articles_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  final dio = Dio();
  final newsService = NewsService(dio);
  final newsRepository = NewsRepositoryImpl(newsService: newsService);
  debugPrintEndFrameBanner = false;
  runApp(NewsCloud(
    repository: newsRepository,
  ));
}

class NewsCloud extends StatelessWidget {
  const NewsCloud({super.key, required this.repository});
  final NewsRepository repository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<NewsRepository>.value(
      value: repository,
      child: BlocProvider<NewsCubit>(
        create: (context) => NewsCubit(
          getTopHeadlines: GetTopHeadlines(repository: repository),
          searchArticles: SearchArticles(repository: repository),
        )..loadGeneralNews(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.home,
          onGenerateRoute: RouteGenerator.generateRoute,
          title: 'NewsCloud',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.black,
            ),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
