import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/core/config/theme/cubit/theme_cubit.dart';
import 'package:news_cloud/core/config/theme_data/app_colors.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_cubit.dart';
import 'package:news_cloud/features/presentation_layer/widgets/categories_list_view.dart';
import 'package:news_cloud/features/presentation_layer/widgets/news_list_view_builder.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() => _isSearching = !_isSearching);
    if (!_isSearching) {
      _searchController.clear();
      context.read<NewsCubit>().loadGeneralNews();
    }
  }

  void _onChanged(String query) {
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      context.read<NewsCubit>().loadGeneralNews();
      return;
    }

    context.read<NewsCubit>().searchNews(query: trimmed);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _toggleSearch,
                  ),
                ),
                onChanged: _onChanged,
              )
            : const Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'News',
                ),
                TextSpan(
                    text: 'Cloud',
                    style: TextStyle(color: AppColors.secondTitle)),
              ])),
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              bool isDarkMode = themeMode == ThemeMode.dark;
              log(isDarkMode.toString());
              return PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                ),
                onSelected: (value) {
                  if (value == 'search') {
                    if (!_isSearching) {
                      _toggleSearch();
                    }
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'search',
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 12),
                        Text('Search',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    child: BlocBuilder<ThemeCubit, ThemeMode>(
                      builder: (context, themeMode) {
                        final isDarkMode = themeMode == ThemeMode.dark;

                        return Row(
                          children: [
                            Icon(
                              Icons.dark_mode,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Dark mode',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: isDarkMode,
                                onChanged: (value) {
                                  context.read<ThemeCubit>().changeTheme();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
      body: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  if (!_isSearching) ...[
                    const SliverToBoxAdapter(
                      child: CategoriesListView(),
                    ),
                  ],
                  const NewsListViewBuilder<NewsCubit>(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
