import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  AuthRepositoryImpl(this._auth);

  @override
  Future<void> registerUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );

      Navigator.popAndPushNamed(context, "/login");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigasi ke halaman Home setelah login berhasil
      Navigator.popAndPushNamed(context, "/home");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  @override
  String? userSession() {
    final user = _auth.currentUser?.uid;
    return user;
  }
}
