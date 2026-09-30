import 'package:flutter/material.dart';

void nectarNavigate(BuildContext context, Widget targetScreen) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => targetScreen,
    ),
  );
}
