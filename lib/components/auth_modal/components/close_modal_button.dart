import 'package:flutter/material.dart';

class CloseModalButton extends StatelessWidget {
  const CloseModalButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
