import 'package:flutter/material.dart';

/// Text in basic areas.
/// 18 font size as default.
class NectarRegularText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const NectarRegularText(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.fade,
    this.color,
    this.fontSize = 16,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
    );
  }
}
