import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/features/presentation_layer/cubit/category_cubit/category_cubit.dart';
import 'package:news_cloud/features/presentation_layer/widgets/custom_app_bar.dart';
import 'package:news_cloud/features/presentation_layer/widgets/news_list_view_builder.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.category});

  final String category;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().loadCategory(
          category: widget.category.toLowerCase(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F3),
      appBar: CustomAppBar(
        title: widget.category,
      ),
      body: const Padding(
        padding: EdgeInsets.all(6),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            NewsListViewBuilder<CategoryCubit>(),
          ],
        ),
      ),
    );
  }
}
