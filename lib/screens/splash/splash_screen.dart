import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkies/providers/app_auth_provider.dart';

import '../auth/login_screen/login_screen.dart';
import '../hero_screen/hero_screen.dart';
import 'package:device_info/device_info.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String deviceId; // Global variable to store the device ID

  @override
  void initState() {
    super.initState();
    _getDeviceId();
    Future.delayed(
      const Duration(seconds: 2),
          () {
        final screenSize = MediaQuery.of(context).size;
        if (screenSize.width > 500) {
          // If the user is logged in, navigate to the HeroScreen
          AppAuthProvider authProvider =
          Provider.of<AppAuthProvider>(context, listen: false);
          if (authProvider.user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HeroScreen()),
            );
          } else {
            // If the user is not logged in, navigate to the LoginScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        } else {
          // If the screen width is not greater than 500, navigate to the HeroScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HeroScreen()),
          );
        }
      },
    );
  }


  Future<void> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String id="";
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      id = androidInfo.androidId;
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor;
    }
    setState(() {
      deviceId = id;
    });
    print(deviceId);
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
                width: constraints.maxWidth > 750
                    ? constraints.maxWidth * 0.35
                    : constraints.maxWidth * 0.55,
                child: Image.asset("assets/png_images/icon.png"),
              ),
            ),
          );
        },
      ),
    );
  }
}
