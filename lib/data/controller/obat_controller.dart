// ignore_for_file: use_build_context_synchronously, avoid_print

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/ui/home_screen.dart';

class Obatcontroller {
  void addData() {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "nama_obat": "Smomp",
      "jumlah": 0,
    };

    print('Document Created!');

    // Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
