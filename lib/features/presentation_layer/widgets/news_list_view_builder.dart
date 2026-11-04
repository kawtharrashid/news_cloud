import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_cubit.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_state.dart';
import 'package:news_cloud/features/presentation_layer/widgets/news_card.dart';
import 'package:news_cloud/features/presentation_layer/widgets/show_alert_dialog.dart';

import 'news_list_shimmer.dart';

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
          return const NewsListShimmer();
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
              child: CustomAlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error_outline_outlined, size: 20, color: Colors.red),
                SizedBox(
                  width: 8,
                ),
                Text("Error")
              ],
            ),
            content: state.failure.message,
            onPressedCancel: () => SystemNavigator.pop(),
            onPressedOK: () => context.read<NewsCubit>().loadGeneralNews(),
          ));
        }
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}

// Widget showSnackbar(
//   BuildContext context,
//   String message,
// ) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//       behavior: SnackBarBehavior.floating,
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       backgroundColor: Colors.grey.shade900,
//       duration: const Duration(seconds: 2),
//     ),
//   );
// }
