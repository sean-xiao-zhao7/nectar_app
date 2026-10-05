import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:nectar_app/components/text/nectar_large_text.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';

/// Default button for Nectar
///
/// Based on ElevatedButton.
/// If [isFullWidth] is true, SizedBox wraps the ElevatedButton.
/// [NectarRegularText] is the label.
class NectarRegularButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final IconData? iconData;
  final FaIconData? faIconData;
  final bool hasDelay, parentIsLoading, isFullWidth;
  final Color? backgroundColor, labelTextColor;

  const NectarRegularButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.isFullWidth = true,
      this.padding,
      this.icon,
      this.iconData = Icons.login_sharp,
      this.faIconData,
      this.hasDelay = true,
      this.parentIsLoading = false,
      this.backgroundColor,
      this.labelTextColor});

  @override
  State<NectarRegularButton> createState() => _NectarRegularButtonState();
}

class _NectarRegularButtonState extends State<NectarRegularButton> {
  // _isLoading is only used for a 1 second delay, this overrides parent's isLoading
  bool _isLoading = false;

  Future<void> _handlePressed() async {
    if (widget.onPressed == null) return;

    // triggers a 1 second delay if needed
    if (widget.hasDelay == true) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }

    if (mounted) {
      widget.onPressed!();
    }
  }

  Widget _buildIcon(Color iconColor) {
    if (widget.icon != null) {
      return widget.icon!;
    }
    if (widget.faIconData != null) {
      return FaIcon(
        widget.faIconData,
        size: 26,
        color: iconColor,
      );
    }
    return Icon(
      widget.iconData,
      size: 30,
      color: iconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor ??
        Theme.of(context).colorScheme.primaryContainer;
    final labelTextColor = widget.labelTextColor ??
        Theme.of(context).colorScheme.onPrimaryContainer;

    final isButtonLoading = _isLoading || (widget.parentIsLoading);
    final isButtonDisabled = widget.onPressed == null || isButtonLoading;

    final button = ElevatedButton.icon(
      // disable button and show loading spinner if disabled, parent passes isLoading, or delay is active
      onPressed: isButtonDisabled ? null : _handlePressed,
      style: ElevatedButton.styleFrom(
          padding: widget.padding ?? const EdgeInsets.all(18),
          backgroundColor: backgroundColor),
      label: NectarLargeText(
        widget.label,
        color: labelTextColor,
      ),
      icon: isButtonLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: widget.labelTextColor ?? labelTextColor,
              ))
          : _buildIcon(widget.labelTextColor ?? labelTextColor),
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
