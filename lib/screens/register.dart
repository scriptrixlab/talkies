import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talkies/screens/welcome.dart';

import '../const/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String name = '';
  String mobile = '';
  String password = '';
  String field_error = '';
  final _firestore = FirebaseFirestore.instance;

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
                field_error,
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
        final credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Add user data to Firestore
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'name': name,
          'mobile': mobile,
          'email': email,
          'password': password,
        });

        setState(() {
          field_error = ''; // Clear any previous errors
        });

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'weak-password') {
            field_error = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            field_error = 'The account already exists for that email.';
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
        field_error = 'All fields must be filled out';
      });
      return false;
    }
    if (password.length < 6) {
      setState(() {
        field_error = 'Password length must be greater than 6';
      });
      return false;
    }

    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)) {
      setState(() {
        field_error = 'Invalid email format';
      });
      return false;
    }

    if (mobile.length != 10 ||
        !mobile.startsWith('9') &&
            !mobile.startsWith('8') &&
            !mobile.startsWith('7')) {
      setState(() {
        field_error = 'Invalid mobile format';
      });
      return false;
    }

    setState(() {
      // Reset fieldError if all validations pass
      field_error = '';
    });

    return true;
  }
}
