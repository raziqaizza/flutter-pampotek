// ignore_for_file: use_build_context_synchronously, avoid_print

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/data/models/data_layer.dart';
import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';
import 'package:flutter_pampotek/domain/repositories/obat_repository.dart';
import 'package:flutter_pampotek/ui/home_screen.dart';

import 'package:firebase_database/firebase_database.dart';

class ObatRepositoryImpl implements ObatRepository {
  DatabaseReference db;

  ObatRepositoryImpl(this.db);

  String? _getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }

    return user.uid;
  }

  DatabaseReference _getObatRef() {
    final uid = _getCurrentUserId();
    if (uid == null) {
      throw Exception('Pengguna belum login');
    }

    return db.child('obat');
  }

  @override
  Stream<List<ObatEntitiy>> getObat() {
    try {
      final uid = _getCurrentUserId();
      if (uid == null) {
        return Stream.value([]);
      }

      return _getObatRef().onValue.map((event) {
        // if (event.snapshot.value == null) {
        //   print("gaada data wlee");
        //   return [];
        // }
        // final data = event.snapshot.value as Map<dynamic, dynamic>?;

        // print(event.snapshot.value.toString());

        // if (data != null) {
        //   return data.entries.map((e) {
        //     final obatJson = Map<String, dynamic>.from(e.value);
        //     print(obatJson);
        //     return ObatModel.fromJson(obatJson).toEntity();
        //   }).toList();
        // }

        if (event.snapshot.value == null) {
          print("Data tidak ditemukan");
          return [];
        }

        // Periksa apakah data berupa Map
        if (event.snapshot.value is Map<dynamic, dynamic>) {
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          print("Snapshot data as Map: $data");

          return data.entries.map((e) {
            final obatJson = Map<String, dynamic>.from(e.value);
            print("Parsed Obat JSON: $obatJson");

            return ObatModel.fromJson(obatJson).toEntity();
          }).toList();
        }

        // Jika data berupa List
        if (event.snapshot.value is List<dynamic>) {
          final data = event.snapshot.value as List<dynamic>;
          print("Snapshot data as List: $data");

          return data.where((e) => e != null).map((e) {
            final obatJson = Map<String, dynamic>.from(e);
            print("Parsed Obat JSON: $obatJson");

            return ObatModel.fromJson(obatJson).toEntity();
          }).toList();
        }

        print("Data tidak sesuai format yang diharapkan");
        return [];
      });
    } catch (e) {
      return Stream.error(e);
    }
  }

  @override
  Future<void> addObat(ObatEntitiy obat) async {
    try {
      final uid = _getCurrentUserId();
      if (uid == null) {
        throw Exception('Pengguna belum login');
      }
      final model = ObatModel.fromEntity(obat);
      await _getObatRef().child(model.id).set(model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteObat(String id) async {
    try {
      final uid = _getCurrentUserId();
      if (uid == null) {
        throw Exception('Pengguna belum login');
      }
      await _getObatRef().child(id).remove();
    } catch (e) {
      // Tangani pengecualian jika pengguna belum login
      rethrow; // Rethrow error agar dapat ditangani di UI
    }
  }

  @override
  Future<void> editObat(ObatEntitiy obat) async {
    try {
      final uid = _getCurrentUserId();
      if (uid == null) {
        throw Exception('Pengguna belum login');
      }

      db.update(ObatModel.fromEntity(obat).toJson());
    } catch (e) {
      rethrow;
    }
  }
}
