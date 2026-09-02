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
  final IconData? iconData;
  final bool? hasDelay;
  final bool? isLoading;

  const MyRegularButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.isFullWidth = true,
      this.padding,
      this.iconData = Icons.login_rounded,
      this.hasDelay = true,
      this.isLoading = false});

  @override
  State<MyRegularButton> createState() => _MyRegularButtonState();
}

class _MyRegularButtonState extends State<MyRegularButton> {
  bool? _isLoading;

  @override
  void initState() {
    _isLoading = widget.isLoading ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton.icon(
      onPressed: _isLoading!
          ? null
          : () {
              setState(() {
                _isLoading = true;
              });
              if (widget.hasDelay!) {
                Future.delayed(const Duration(seconds: 1), () {
                  widget.onPressed!();
                  setState(() {
                    _isLoading = false;
                  });
                });
              } else {
                widget.onPressed!();
                setState(() {
                  _isLoading = false;
                });
              }
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
      icon: _isLoading!
          ? SizedBox(
              height: 20,
              width: 20,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
              ))
          : Icon(widget.iconData),
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
