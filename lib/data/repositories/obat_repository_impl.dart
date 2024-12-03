import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/data/models/obat_model.dart';
import 'package:flutter_pampotek/domain/entities/obat_entity.dart';
import 'package:flutter_pampotek/domain/repositories/obat_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_pampotek/main.dart';

class ObatRepositoryImpl implements ObatRepository {
  DatabaseReference db;

  ObatRepositoryImpl(this.db);

  // Check session
  String? _getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    return user.uid;
  }

  // Get database
  DatabaseReference _getObatRef() {
    final uid = _getCurrentUserId();
    if (uid == null) {
      throw Exception('Pengguna belum login');
    }
    return db.child('obat');
  }

  @override
  Stream<List<ObatEntity>> getObat() {
    try {
      final uid = _getCurrentUserId();

      if (uid == null) {
        return Stream.value([]);
      }

      return _getObatRef().onValue.map((event) {
        if (event.snapshot.value == null) {
          return [];
        }

        if (event.snapshot.value is Map) {
          print('Data is Map');

          final data = event.snapshot.value as Map<dynamic, dynamic>;

          return data.entries
              .map((entry) {
                final key = entry.key as String;
                final obatJson = entry.value;

                if (obatJson == null) return null;

                final obatMap = Map<String, dynamic>.from(obatJson);

                // Membuat ObatEntity
                final entity =
                    ObatModel.fromJson({...obatMap, "id": key}).toEntity();

                // Debug: Print entity
                print("Entity: ${entity.id}");

                return entity;
              })
              .whereType<ObatEntity>()
              .toList();
        }

        if (event.snapshot.value is List<dynamic>) {
          print('Data is List');
          final data = event.snapshot.value as List<dynamic>;

          return data
              .asMap()
              .entries
              .map((entry) {
                final index = entry.key;
                final obatJson = entry.value;

                if (obatJson == null) return null;

                final obatMap = Map<String, dynamic>.from(obatJson as Map);

                final entity =
                    ObatModel.fromJson({...obatMap, "id": index.toString()})
                        .toEntity();

                // Debug: Print Entity
                print("Entity: ${entity.id}");

                return ObatModel.fromJson({...obatMap, "id": index.toString()})
                    .toEntity();
              })
              .whereType<ObatEntity>()
              .toList();
        }
        return [];
      });
    } catch (e) {
      return Stream.error(e);
    }
  }

  @override
  Future<void> addObat(ObatEntity obat) async {
    try {
      final uid = _getCurrentUserId();

      if (uid == null) {
        throw Exception('Pengguna belum login');
      }

      final model = ObatModel.fromEntity(obat);

      final snapshot = await _getObatRef().get();

      int nextId = 1;
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        // Ambil semua keys yang ada di Map dan tentukan ID berikutnya
        final validIds =
            data.keys.map((key) => int.tryParse(key.toString()) ?? 0).toList();

        nextId = validIds.isNotEmpty
            ? validIds.reduce((a, b) => a > b ? a : b) + 1
            : 1;
      }

      await _getObatRef().child(nextId.toString()).set({
        ...model.toJson(),
      });

      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Obat added successfully')),
      );
    } catch (e) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to update obat: $e')),
      );
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

      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Obat deleted successfully')),
      );
    } catch (e) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to delete obat: $e')),
      );
    }
  }

  @override
  Future<void> editObat(ObatEntity obat) async {
    try {
      final uid = _getCurrentUserId();

      if (uid == null) {
        throw Exception('Pengguna belum login');
      }

      if (obat.id.isEmpty) {
        throw Exception('ID obat tidak ditemukan');
      }

      final model = ObatModel.fromEntity(obat);

      await _getObatRef().child(obat.id).update(model.toJson());

      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Obat updated successfully')),
      );
    } catch (e) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to update obat: $e')),
      );
    }
  }
}
