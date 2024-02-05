import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkies/providers/app_auth_provider.dart';
import 'package:talkies/screens/register.dart';
import 'package:talkies/screens/welcome.dart';

import '../const/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;
  late String fieldError = "";
  late AppAuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    fieldError = '';
    authProvider = Provider.of<AppAuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                "Login",
                style: AppStyles.textStyle18,
              ),
              const SizedBox(
                width: 20,
                height: 20,
              ),
              // mail Text Field
              SizedBox(
                width: 250,
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Email',
                  ),
                  style: TextStyle(fontSize: 16.0),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                width: 250,
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  textAlignVertical: TextAlignVertical(y: 1),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Password',
                  ),
                  style: TextStyle(fontSize: 16.0),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              Text(
                fieldError,
                style: TextStyle(color: Colors.red),
              ),
              //login Button
              ElevatedButton(
                onPressed: _onLoginBtnClick,
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.black),
                ),
              ),

              //go to register btn
              ElevatedButton(
                onPressed: () async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: const Text(
                  "Go To Reister",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //other methods
  // Inside _onLoginBtnClick method in LoginPage
  void _onLoginBtnClick() async {
    if (_validateInputs()) {
      try {
        await authProvider.signIn(email, password);
        setState(() {
          fieldError = ''; // Clear any previous errors
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'user-not-found') {
            fieldError = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            fieldError = 'Wrong password provided for that user.';
          } else {
            fieldError = 'Sign-in failed. Please try again.';
          }
        });
      }
    }
  }


  bool _validateInputs() {
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        fieldError = 'All fields must be filled out';
      });
      return false;
    }
    if (password.length < 6) {
      setState(() {
        fieldError = "password length must be greater than 6";
      });
      return false;
    }
    setState(() {
      // Reset fieldError if all validations pass
      fieldError = '';
    });

    return true;
  }
}
