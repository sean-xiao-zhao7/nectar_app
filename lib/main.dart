import 'package:flutter/material.dart';
import 'package:nectar_app/screens/auth/register_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 248, 228)),
      ),
      home: const RegisterScreen(),
    );
  }
}
