import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:talkies/providers/app_auth_provider.dart';

import '../auth/login_screen/login_screen.dart';
import '../hero_screen/hero_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String deviceId;

  String _locationMessage = ""; // Global variable to store the device ID

  @override
  void initState() {
    super.initState();
    _getDeviceId();
    _getLocation();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final screenSize = MediaQuery.of(context).size;
        if (screenSize.width > 500) {
          // If the user is logged in, navigate to the HeroScreen
          AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context, listen: false);
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

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationDisabledDialog();
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          Geolocator.requestPermission();
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _showLocationDisabledDialog();
      });
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _locationMessage = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    });
    print(_locationMessage);
  }

  void _showLocationDisabledDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Permission Disabled"),
          content: Text("Please allow location services to access this feature."),
          actions: [
            TextButton(
              child: Text("Settings"),
              onPressed: () {
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String id = "";
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
                width: constraints.maxWidth > 750 ? constraints.maxWidth * 0.35 : constraints.maxWidth * 0.55,
                child: Image.asset("assets/png_images/icon.png"),
              ),
            ),
          );
        },
      ),
    );
  }
}
