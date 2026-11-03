import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/features/presentation_layer/cubit/news_cubit/news_cubit.dart';

class ShowAlertDialog extends StatelessWidget {
  const ShowAlertDialog({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 20),
          const SizedBox(width: 8),
          Text(
            'Error',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            context.read<NewsCubit>().loadGeneralNews();
          },
          child: const Text(
            'OK',
          ),
        ),
      ],
    );
  }
}
