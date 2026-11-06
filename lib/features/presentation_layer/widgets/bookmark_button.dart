import 'package:flutter/material.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton(
      {super.key, required this.onPressed, required this.isSaved});
  final Future<void> Function() onPressed;
  final bool isSaved;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border,
        ));
  }
}
