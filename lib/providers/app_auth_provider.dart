// app_auth_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AppAuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions if needed
      throw e;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String mobile,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'name': name,
        'mobile': mobile,
        'email': email,
        'password': password,
      });

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle registration exceptions if needed
      throw e;
    }
  }
}
