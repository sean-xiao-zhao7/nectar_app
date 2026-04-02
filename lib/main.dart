import 'package:flutter/material.dart';
import 'package:nectar_app/screens/home_screen.dart';

void main() {
  runApp(const NectarApp());
}

class NectarApp extends StatelessWidget {
  const NectarApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Nectar Primary Yellow
    const nectarLightYellow = Color.fromARGB(255, 255, 209, 72);
    const nectarDarkYellow = Color.fromARGB(255, 169, 127, 0);
    const nectarWhite = Colors.white;

    return MaterialApp(
      title: 'Nectar',
      theme: ThemeData(
          fontFamily: 'Inter',
          scaffoldBackgroundColor: nectarLightYellow,
          colorScheme: ColorScheme.fromSeed(seedColor: nectarLightYellow),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'Lora',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: nectarDarkYellow),
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontFamily: 'Lora'),
            headlineMedium: TextStyle(fontFamily: 'Lora'),
            headlineSmall: TextStyle(fontFamily: 'Lora'),
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor: nectarWhite,
          )),
      home: const HomeScreen(),
    );
  }
}
