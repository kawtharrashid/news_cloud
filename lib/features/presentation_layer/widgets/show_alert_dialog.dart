import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.onPressedOK,
    this.onPressedCancel,
  });

  final Widget title;
  final String content;
  final VoidCallback? onPressedOK;
  final VoidCallback? onPressedCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onPressedCancel,
          child: const Text(
            'Cancel',
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: onPressedOK,
          child: const Text(
            'OK',
          ),
        ),
      ],
    );
  }
}
