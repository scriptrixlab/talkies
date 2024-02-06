import 'package:flutter/material.dart';
import 'package:talkies/screens/hero_screen/hero_screen_ui/hero_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: constraints.maxWidth > 750
                          ? constraints.maxWidth * 0.25
                          : constraints.maxWidth * 0.35,
                      child: Image.asset("assets/png_images/icon.png")),
                  const SizedBox(
                    height: 20,
                  ),
                  ///TODO Check for login flag implement later
                  constraints.maxWidth > 750
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///TODO qr part
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:
                              constraints.maxWidth > 750 ? 290 : 200,
                              height:
                              constraints.maxWidth > 750 ? 290 : 170,
                              child: Image.asset(
                                "assets/png_images/dummy_qr.png",
                              ),
                            ),

                            ///TODO dynamic link
                            const Text(
                              "Login_Link",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: constraints.maxWidth * 0.03,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: constraints.maxWidth > 750
                              ? 250
                              : 180, // Adjust height as needed
                          width: 6, // Width of the divider
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth > 750
                            ? constraints.maxWidth * 0.11
                            : constraints.maxWidth * 0.03,
                      ),

                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Username',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width:
                              constraints.maxWidth > 750 ? 300 : 200,
                              height:
                              constraints.maxWidth > 750 ? 60 : 40,
                              child: const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter User Name',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const Text(
                              'Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width:
                              constraints.maxWidth > 750 ? 300 : 200,
                              height:
                              constraints.maxWidth > 750 ? 60 : 40,
                              child: const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter password',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width:
                              constraints.maxWidth > 750 ? 100 : 80,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const HeroScreen(),
                                      ));
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8), // Adjust border radius as needed
                                    ),
                                  ),
                                ),
                                child: const Text('Go'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                      : SizedBox(
                    width: constraints.maxWidth * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Username',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(
                          height: 60,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter User Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(
                          height: 60,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const HeroScreen(),
                                    ));
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Adjust border radius as needed
                                  ),
                                ),
                              ),
                              child: const Text('Go'),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
