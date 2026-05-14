import 'package:flutter/material.dart';

import 'package:nectar_app/components/text/my_regular_text.dart';

/// Default button for Nectar
///
/// Based on ElevatedButton.
/// If [isFullWidth] is true, SizedBox wraps the ElevatedButton.
/// [MyRegularText] is the label.
class MyRegularButton extends StatefulWidget {
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
  State<MyRegularButton> createState() => _MyRegularButtonState();
}

class _MyRegularButtonState extends State<MyRegularButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton.icon(
      onPressed: () {
        setState(() {
          _isLoading = true;
        });
        Future.delayed(const Duration(seconds: 1), () {
          widget.onPressed!();
          setState(() {
            _isLoading = false;
          });
        });
      },
      style: ElevatedButton.styleFrom(
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      label: MyRegularText(
        widget.label,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      ),
      icon: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
              ))
          : const Icon(Icons.login_rounded),
    );

    if (widget.isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}
