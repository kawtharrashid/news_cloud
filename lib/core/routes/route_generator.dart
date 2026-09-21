import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/domain_layer/repositories/news_repository.dart';
import 'package:news_cloud/features/domain_layer/usecases/get_top_headlines_usecase.dart';
import 'package:news_cloud/features/presentation_layer/cubit/category_cubit/category_cubit.dart';
import 'package:news_cloud/features/presentation_layer/views/article_details_view.dart';
import 'package:news_cloud/features/presentation_layer/views/category_view.dart';
import 'package:news_cloud/features/presentation_layer/views/home_view.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case AppRoutes.articleDetails:
        final article = settings.arguments as ArticleEntity;

        return MaterialPageRoute(
          builder: (_) => ArticleDetailsView(
            article: article,
          ),
        );
      case AppRoutes.category:
        final category = settings.arguments as String;

        return MaterialPageRoute(
          builder: (context) => BlocProvider<CategoryCubit>(
            create: (_) => CategoryCubit(
              getTopHeadlines: GetTopHeadlines(
                repository: RepositoryProvider.of<NewsRepository>(context),
              ),
            ),
            child: CategoryView(
              category: category,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
