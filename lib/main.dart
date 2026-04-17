import 'package:flutter/material.dart';

import 'package:nectar_app/theme/main_theme.dart';
import 'package:nectar_app/screens/home_screen.dart';

/// Nectar App entry point
///
/// A material app with theme based on "yellow" colour. See theme file.
/// Shows HomeScreen first.
class NectarApp extends StatelessWidget {
  const NectarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nectar',
      theme: initTheme(Brightness.light),
      home: const HomeScreen(),
    );
  }
}

void main() {
  runApp(const NectarApp());
}
