import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkies/screens/hero_screen/hero_screen.dart';

import '../../../providers/app_auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String fieldError = "";

  late String emailRegister = "";
  late String passwordRegister = "";

  late String fieldErrorRegister = "";

  late AppAuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AppAuthProvider>(context, listen: false);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: constraints.maxWidth > 750 ? constraints.maxWidth * 0.25 : constraints.maxWidth * 0.50,
                      child: Image.asset("assets/png_images/icon.png")),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(32),
                    child: GestureDetector(
                      onTap: _googleSignin,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/png_images/google_icon.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  Future<void> _googleSignin() async {
    try {
      await authProvider.signInWithGoogle();
      setState(() {
        fieldError = ''; // Clear any previous errors
      });
      // Check if the user is signed in before making the API call
      final user = authProvider.user;
      if (user != null) {
        // var username = user.email;
        // var password = user.uid;

        // Prepare the body for the API call
        var body = {
          'username': "ARIT_DEV",
          'password': "ARIT_DEV",
        };

        // Make the API call
        var response = await http.post(
          Uri.parse('http://dabbatalkies.com/api.ramovies.app/api/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );

        // Check the response status
        if (response.statusCode == 200) {
          // Handle successful response
          print('API call successful' + response.body);
          var token = response.body;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          // Do something with the response if needed
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HeroScreen()),
          );
        } else {
          // Handle error response
          print('API call failed with status: ${response.body}');
          // Do something with the error response if needed
        }
      }
    } catch (e) {
      setState(() {
        fieldError = e.toString();
      });
    }
  }
}
