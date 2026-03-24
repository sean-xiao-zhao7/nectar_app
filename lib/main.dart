import 'package:flutter/material.dart';
import 'package:nectar_app/screens/home_screen.dart';

void main() {
  runApp(const NectarApp());
}

class NectarApp extends StatelessWidget {
  const NectarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nectar',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 209, 72),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            primaryContainer: const Color.fromARGB(255, 255, 209, 72),
            onPrimary: Colors.white,
            secondaryContainer: Colors.white,
            onSecondaryContainer: const Color.fromARGB(255, 169, 127, 0),
            tertiaryContainer: const Color.fromARGB(255, 255, 250, 234),
          )),
      home: const HomeScreen(),
    );
  }
}
