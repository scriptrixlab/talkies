import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkies/providers/app_auth_provider.dart';
import 'package:talkies/screens/welcome.dart';

import '../const/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String name = '';
  String mobile = '';
  String password = '';
  String fieldError = '';
  late AppAuthProvider authProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fieldError = '';
    authProvider = Provider.of<AppAuthProvider>(context, listen: true);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Register", style: AppStyles.textStyle20),
              const SizedBox(
                width: 20,
                height: 20,
              ),

              //mail text field
              TextField(
                keyboardType: TextInputType.emailAddress,
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
                  hintText: 'Enter email',
                ),
                style: TextStyle(fontSize: 16.0),
                maxLines: 1,
              ),
              TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  name = value;
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
                  hintText: 'Enter name',
                ),
                style: TextStyle(fontSize: 16.0),
                maxLines: 1,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  mobile = value;
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
                  hintText: 'Enter mobile number',
                ),
                style: TextStyle(fontSize: 16.0),
                maxLines: 1,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
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
                  hintText: 'Enter password',
                ),
                style: TextStyle(fontSize: 16.0),
                maxLines: 1,
              ),

              const SizedBox(
                width: 20,
                height: 20,
              ),
              Text(
                fieldError,
                style: TextStyle(color: Colors.red),
              ),
              //register button
              ElevatedButton(
                  onPressed: _registerButtonClick,
                  child: const Text("Register"))
            ],
          ),
        ),
      ),
    );
  }

  //other methods

  void _registerButtonClick() async {
    if (_validateInputs()) {
      try {
        await authProvider.registerUser(
          email: email,
          password: password,
          name: name,
          mobile: mobile,
        );

        setState(() {
          fieldError = ''; // Clear any previous errors
        });

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'weak-password') {
            fieldError = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            fieldError = 'The account already exists for that email.';
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }


  bool _validateInputs() {
    if (email.isEmpty || name.isEmpty || mobile.isEmpty || password.isEmpty) {
      setState(() {
        fieldError = 'All fields must be filled out';
      });
      return false;
    }
    if (password.length < 6) {
      setState(() {
        fieldError = 'Password length must be greater than 6';
      });
      return false;
    }

    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)) {
      setState(() {
        fieldError = 'Invalid email format';
      });
      return false;
    }

    if (mobile.length != 10 ||
        !mobile.startsWith('9') &&
            !mobile.startsWith('8') &&
            !mobile.startsWith('7')) {
      setState(() {
        fieldError = 'Invalid mobile format';
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
