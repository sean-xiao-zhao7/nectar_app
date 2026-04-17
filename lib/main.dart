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
    const nectarDarkerYellow = Color.fromARGB(255, 95, 68, 0);
    const nectarWhite = Colors.white;
    const nectarRed = Colors.red;

    return MaterialApp(
      title: 'Nectar',
      theme: ThemeData(
          fontFamily: 'Inter',
          scaffoldBackgroundColor: nectarLightYellow,
          colorScheme: ColorScheme(
            primary: nectarLightYellow,
            onPrimary: nectarWhite,
            secondary: nectarDarkYellow,
            onSecondary: nectarWhite,
            tertiary: nectarDarkerYellow,
            onTertiary: nectarWhite,
            brightness: Brightness.light,
            error: nectarRed,
            onError: nectarWhite,
            surface: nectarLightYellow,
            onSurface: nectarDarkerYellow,
          ),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: nectarDarkYellow),
            backgroundColor: nectarWhite,
            titleTextStyle: TextStyle(
                fontFamily: 'Lora',
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: nectarDarkYellow),
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontFamily: 'Lora'),
            headlineMedium: TextStyle(fontFamily: 'Lora'),
            headlineSmall: TextStyle(fontFamily: 'Lora'),
          ),
          drawerTheme: DrawerThemeData()),
      home: const HomeScreen(),
    );
  }
}
