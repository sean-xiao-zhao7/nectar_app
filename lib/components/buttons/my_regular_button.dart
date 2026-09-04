import 'package:flutter/material.dart';
import 'package:nectar_app/components/text/my_large_text.dart';

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
  final IconData? iconData;
  final bool? hasDelay;
  final bool parentIsLoading;

  const MyRegularButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.isFullWidth = true,
      this.padding,
      this.iconData = Icons.login_sharp,
      this.hasDelay = true,
      this.parentIsLoading = false});

  @override
  State<MyRegularButton> createState() => _MyRegularButtonState();
}

class _MyRegularButtonState extends State<MyRegularButton> {
  // _isLoading is only used for a 1 second delay, this overrides parent's isLoading
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton.icon(
      // disable button and show loading spinning if either parent passes an isLoading, or 1 second delay is activated
      onPressed: _isLoading || widget.parentIsLoading
          ? null
          : () {
              if (widget.hasDelay!) {
                setState(() {
                  _isLoading = true;
                });
                Future.delayed(const Duration(seconds: 1), () {
                  widget.onPressed!();
                });
                setState(() {
                  _isLoading = false;
                });
              } else {
                widget.onPressed!();
              }
            },
      style: ElevatedButton.styleFrom(
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      label: MyLargeText(
        widget.label,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      icon: _isLoading || widget.parentIsLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
              ))
          : Icon(
              widget.iconData,
              size: 24,
            ),
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
