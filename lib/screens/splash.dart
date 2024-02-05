import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talkies/screens/welcome.dart';
import 'package:talkies/screens/login.dart'; // Assuming you have a LoginPage

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserSignInStatus();
    });
  }

  Future<void> checkUserSignInStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(100),
                child: Image.asset(
                  "assets/images/icon.png",
                  fit: BoxFit.fitWidth,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
