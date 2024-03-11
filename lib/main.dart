import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/game_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.silkscreenTextTheme(),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/game', page: () => const GameScreen()),
      ],
    );
  }
}
