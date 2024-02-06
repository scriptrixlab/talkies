import 'package:flutter/material.dart';

import '../hero_screen/hero_screen_ui/hero_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
          () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HeroScreen(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1A237E),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  image: AssetImage("assets/png_images/background.png"),
                  fit: BoxFit.cover,
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF1A237E),
                    Colors.deepPurple.shade500,
                  ],
                ),
              ),
              child: Center(
                  child: SizedBox(
                    //Handling for
                      width: constraints.maxWidth > 750
                          ? constraints.maxWidth * 0.35
                          : constraints.maxWidth * 0.55,
                      child: Image.asset("assets/png_images/icon.png"))),
            );
          },
        ));
  }
}
