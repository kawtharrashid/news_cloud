import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/core/config/theme_data/app_colors.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_cubit.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_state.dart';
import 'news_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewsListViewBuilder<C extends StateStreamable<NewsState>>
    extends StatelessWidget {
  const NewsListViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: Center(
                child: LoadingAnimationWidget.hexagonDots(
                  size: 40,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          );
        }

        if (state is NewsLoaded) {
          if (state.articles.isEmpty) {
            final cubit = context.read<NewsCubit>();
            final isSearchActive = cubit.isSearchActive;
            final isSearchingQueryIsEmpty = cubit.isSearchingQueryIsEmpty;

            return SliverToBoxAdapter(
              child: SizedBox(
                height: 300,
                child: Center(
                  child: Text(
                    isSearchActive && !isSearchingQueryIsEmpty
                        ? 'No articles found for this search.'
                        : 'No articles available.',
                  ),
                ),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return NewsCard(
                  articleEntity: state.articles[index],
                );
              },
              childCount: state.articles.length,
            ),
          );
        }

        if (state is NewsError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textErrorColor,
                  ),
                ),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
