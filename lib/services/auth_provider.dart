import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  // Getter for the current user
  User? get user => _user;

  // Login method
  Future<void> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = result.user;
      notifyListeners();
    } catch (error) {
      // Handle authentication errors here
      print('Error during login: $error');
    }
  }

  // Signup method
  Future<void> signup(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = result.user;
      notifyListeners();
    } catch (error) {
      // Handle authentication errors here
      print('Error during signup: $error');
    }
  }

  // Logout method
  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
