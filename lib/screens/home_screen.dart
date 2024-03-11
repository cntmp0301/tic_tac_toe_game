import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import '../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPressed = false;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tic-Tac-Toe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            const Text(
              'Game',
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
              ),
            ),
            const SizedBox(height: 30),
            NeumorphicButton(
              onTap: () {
                Get.toNamed('/game');
              },
              borderRadius: 12,
              bottomRightShadowBlurRadius: 15,
              bottomRightShadowSpreadRadius: 1,
              borderWidth: 2,
              backgroundColor: MainColor.secondaryColor,
              topLeftShadowBlurRadius: 15,
              topLeftShadowSpreadRadius: 1,
              topLeftShadowColor: MainColor.primaryColor,
              bottomRightShadowColor: const Color(0xFF050438),
              height: size.width * 0.15,
              width: size.width * 0.4,
              padding: EdgeInsets.zero,
              bottomRightOffset: const Offset(4, 4),
              topLeftOffset: const Offset(-4, -4),
              child: const Center(
                child: Text(
                  "start",
                  style: TextStyle(fontSize: 28),
                ),
              ),
            )
            // NeumorphicButton(
            //   onTap: () {
            //     Get.toNamed('/game');
            //   },
            //   borderRadius: 12,
            //   bottomRightShadowBlurRadius: 15,
            //   bottomRightShadowSpreadRadius: 1,
            //   borderWidth: 5,
            //   backgroundColor: MainColor.secondaryColor,
            //   topLeftShadowBlurRadius: 15,
            //   topLeftShadowSpreadRadius: 1,
            //   topLeftShadowColor: MainColor.primaryColor,
            //   bottomRightShadowColor: Color(0xFF050438),
            //   height: 50,
            //   width: 100,
            //   padding: const EdgeInsets.all(50),
            //   bottomRightOffset: const Offset(4, 4),
            //   topLeftOffset: const Offset(-4, -4),
            //   child: const Center(child: Text("Hello World")),
            // )
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: MainColor.secondaryColor,
            //   ),
            //   onPressed: () {},
            //   child: const Text(
            //     'Start',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 20,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
