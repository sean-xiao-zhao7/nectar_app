import 'package:flutter/material.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';

class MyRegularButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;

  const MyRegularButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isFullWidth = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      child: MyRegularText(
        label,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      ),
    );

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}
