// ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/ui/home_screen.dart';
import 'package:flutter_pampotek/ui/login_screen.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

      // Kembali ke halaman login setelah berhasil
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
      Navigator.pop(context);
    }
  }

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
      // Proses login
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigasi ke halaman Home setelah login berhasil
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
    } catch (e) {
      // Tampilkan error jika login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
      Navigator.pop(context);
    }
  }
}

class ObatController {}
