import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_auth_provider.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'post_login_register';

  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late User loggedInUser;
  var userEmail = "";
  String userData = "Click below button to fetch";
  late AppAuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      loggedInUser = authProvider.user!;
      userEmail = loggedInUser.email!;
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
                Text("This is user's email:\n $userEmail"),
                Expanded(child: Text(userData)),
                ElevatedButton(
                  onPressed: _fetchUserDocData,
                  child: Text("Fetch User Document"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await authProvider.signOut();
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fetchUserDocData() async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    String? documentId = authProvider.user?.uid;

    try {
      DocumentSnapshot snapshot = await users.doc(documentId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data =
        snapshot.data() as Map<String, dynamic>;

        setState(() {
          userData =
          "Full Name: ${data['name']} \nPhone No: ${data['mobile']} Email: ${data['email']}";
        });
      } else {
        setState(() {
          userData = "Document does not exist";
        });
      }
    } catch (e) {
      setState(() {
        userData = "Something went wrong";
      });
      print(e.toString());
    }
  }
}
