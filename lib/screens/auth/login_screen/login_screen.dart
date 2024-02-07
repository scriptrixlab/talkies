import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkies/screens/hero_screen/hero_screen.dart';

import '../../../providers/app_auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email = "";
  late String password = "";
  late String fieldError = "";

  late String emailRegister = "";
  late String passwordRegister = "";
  late String nameRegister = "";
  late String mobileRegister = "";
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
                                    child: TextField(
                                      onChanged: (value) {
                                        email = value;
                                      },
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter email',
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
                                    child: TextField(
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter password',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    fieldError,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  const SizedBox(height: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width:
                                        constraints.maxWidth > 750 ? 100 : 80,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: _onLoginBtnClick,
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
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _showRegisterDialog(context);
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
                                              child: const Text('Register'),
                                            ),
                                          ),
                                          SizedBox(width: 8, height: 8,),
                                          SizedBox(
                                            height:40,
                                            child: GestureDetector(
                                              onTap: _googleSignin,
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/png_images/google_icon.png"),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                              SizedBox(
                                height: 60,
                                child: TextField(
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  decoration: const InputDecoration(
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
                                height: 60,
                                child: TextField(
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Enter password',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                fieldError,
                                style: TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: _onLoginBtnClick,
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
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: _googleSignin,
                                  child: Container(
                                    width: 120,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/png_images/google_icon.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _showRegisterDialog(context);
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
                                    child: const Text('Register'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          },
        ));
  }

  void _onLoginBtnClick() async {
    if (_validateLoginInputs()) {
      try {
        await authProvider.signIn(email, password);
        setState(() {
          fieldError = ''; // Clear any previous errors
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HeroScreen()));
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

  bool _validateLoginInputs() {
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

  Future<void> _googleSignin() async {
    try {
      await authProvider.signInWithGoogle();
      setState(() {
        fieldError = ''; // Clear any previous errors
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HeroScreen()));
    } catch (e) {
      setState(() {
        fieldError = e.toString();
      });
    }
  }

  void _showRegisterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Register'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        onChanged: (value) {
                          nameRegister = value;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter Your Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    const Text(
                      'Email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        onChanged: (value) {
                          emailRegister = value;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter Your Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Text(
                      'Password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                         ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        onChanged: (value) {
                          passwordRegister = value;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter Your Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    SizedBox(height: 8),

                    const Text(
                      'Mobile',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        onChanged: (value) {
                          mobileRegister = value;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter Your Mobile Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    Text(
                      fieldErrorRegister,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _registerButtonClick();
                  },
                  child: Text('Sign Up'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _registerButtonClick() async {
    if (_validateRegisterInputs()) {
      try {
        AppAuthProvider authProvider =
            Provider.of<AppAuthProvider>(context, listen: false);
        await authProvider.registerUser(
          email: emailRegister,
          password: passwordRegister,
          name: nameRegister,
          mobile: mobileRegister,
        );

        setState(() {
          fieldErrorRegister = ''; // Clear any previous errors
        });
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HeroScreen()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'weak-password') {
            fieldErrorRegister = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            fieldErrorRegister = 'The account already exists for that email.';
          }
        });
      } catch (e) {
        fieldErrorRegister = e.toString();
      }
    } else {
      //in case of invalid input we need to restart the dialog
      Navigator.of(context).pop();
      _showRegisterDialog(context);
    }
  }

  bool _validateRegisterInputs() {
    if (emailRegister.isEmpty ||
        nameRegister.isEmpty ||
        passwordRegister.isEmpty) {
      setState(() {
        fieldErrorRegister = 'All fields must be filled out';
      });
      return false;
    }
    if (passwordRegister.length < 6) {
      setState(() {
        fieldErrorRegister = 'Password length must be greater than 6';
      });
      return false;
    }

    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(emailRegister)) {
      setState(() {
        fieldErrorRegister = 'Invalid email format';
      });
      return false;
    }

    if (mobileRegister.length != 10 ||
        !mobileRegister.startsWith('9') &&
            !mobileRegister.startsWith('8') &&
            !mobileRegister.startsWith('7')) {
      setState(() {
        fieldErrorRegister = 'Invalid mobile format';
      });
      return false;
    }

    setState(() {
      // Reset fieldError if all validations pass
      fieldErrorRegister = '';
    });

    return true;
  }
}
