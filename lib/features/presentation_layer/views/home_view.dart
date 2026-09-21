import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/core/constants.dart';
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
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber[100],
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
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'News',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    'Cloud',
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            color: Colors.black,
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              if (!_isSearching) ...[
                const SliverToBoxAdapter(
                  child: CategoriesListView(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
              ],
              NewsListViewBuilder<NewsCubit>(),
            ],
          ),
        ),
      ),
    );
  }
}
