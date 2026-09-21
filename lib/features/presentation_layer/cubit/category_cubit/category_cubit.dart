import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/features/domain_layer/usecases/get_top_headlines_usecase.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_state.dart';
import '../news_loading_mixin.dart';

class CategoryCubit extends Cubit<NewsState> with NewsLoadingMixin {
  CategoryCubit({
    required this.getTopHeadlines,
  }) : super(const NewsInitial());

  final GetTopHeadlines getTopHeadlines;

  Future<void> loadCategory({
    required String category,
  }) {
    return loadNews(
      () => getTopHeadlines(category: category),
    );
  }
}
