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

  void _onSubmitted(String query) {
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
                autofocus: true,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: 'Search articles...',
                  border: InputBorder.none,
                ),
                onSubmitted: _onSubmitted,
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
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
          IconButton(
              onPressed: () {
                // log(_themeMode.toString());
                log(Theme.of(context).brightness.toString());
                context.read<ThemeCubit>().changeTheme();
              },
              icon: const Icon(Icons.switch_access_shortcut))
        ],
      ),
      body: BlocConsumer<ThemeCubit, ThemeMode>(
        listener: (context, state) {
          // ThemeMode.system == _themeMode,
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 1,
                vertical: 6,
              ),
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
