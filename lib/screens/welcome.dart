import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'post_login_register';

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _auth = FirebaseAuth.instance;
  late User logedInUser;
  var usermail = "";
  String $userdata = "click below button to fetch";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      logedInUser = _auth.currentUser!;
      usermail = logedInUser.email!;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Container(
          child: Column(
            children: [
              Text("Welcome after login"),
              Text("This is users mail:\n $usermail"),
              Expanded(child: Text($userdata)),
              ElevatedButton(
                  onPressed: _fetchUserDocData,
                  child: Text("Fetch User Document")),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Text("Logout"))
            ],
          ),
        )),
      ),
    );
  }

  void _fetchUserDocData() async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    String documentId = _auth.currentUser!.uid;

    try {
      DocumentSnapshot snapshot = await users.doc(documentId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        setState(() {
          $userdata =
              "Full Name: ${data['name']} \nPhone No: ${data['mobile']} Email: ${data['email']}";
        });
      } else {
        setState(() {
          $userdata = "Document does not exist";
        });
      }
    } catch (e) {
      setState(() {
        $userdata = "Something went wrong";
      });
      print(e.toString());
    }
  }
}
