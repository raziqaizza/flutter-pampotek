import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/data/models/transaksi_model.dart';
import 'package:flutter_pampotek/domain/entities/transaksi_entity.dart';
import 'package:flutter_pampotek/domain/repositories/transaksi_repository.dart';
import 'package:flutter_pampotek/main.dart';

class TransaksiRepositoryImpl implements TransaksiRepository{
  DatabaseReference db;

  TransaksiRepositoryImpl(this.db);

  // Check session
  String? _getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    return user.uid;
  }

  // Get database
  DatabaseReference _getTransaksiRef() {
    final uid = _getCurrentUserId();
    if (uid == null) {
      throw Exception('Pengguna tidak ter-autentikasi');
    }
    return db.child('transaksi');
  }

  @override
  Future<void> addTransaksi(TransaksiEntity transaksi) async {
    try {
      final uid = _getCurrentUserId();
      if (uid == null) {
        throw Exception('Pengguna belum login');
      }

      final model = TransaksiModel.fromEntity(transaksi);

      final snapshot = await _getTransaksiRef().get();

      int nextId = 1;
      if (snapshot.exists) {
        Map<dynamic,dynamic> data;

        if (snapshot.value is List<dynamic>) {
          final dataList = snapshot.value as List<dynamic>;
          data = dataList.asMap();
        } else {
          data = snapshot.value as Map<dynamic, dynamic>;
        }


        // Ambil semua keys yang ada di Map dan tentukan ID berikutnya
        final validIds =
            data.keys.map((key) => int.tryParse(key.toString()) ?? 0).toList();

        nextId = validIds.isNotEmpty
            ? validIds.reduce((a, b) => a > b ? a : b) + 1
            : 1;
      }

      await _getTransaksiRef().child(nextId.toString()).set({
        ...model.toJson(),
      });

      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Transaksi added successfully')),
      );
    } catch (e) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to add transaksi: $e')),
      );
    }
  }

  @override
  Future<void> deleteTransaksi(String id) async {
    try {
      final uid = _getCurrentUserId();
      if (uid == null) {
        throw Exception('Pengguna belum login');
      }

      final transaksiRef = _getTransaksiRef();

      // Menghapus transaksi berdasarkan ID
      await transaksiRef.child(id).remove();

      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Transaksi deleted successfully')),
      );
    } catch (e) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to delete transaksi: $e')),
      );
    }
  }

  @override
  Stream<List<TransaksiEntity>> getTransaksi() {
  try {
    final uid = _getCurrentUserId();

    if (uid == null) {
      return Stream.value([]);  // Jika tidak ada user yang login, kembalikan stream kosong
    }

    return _getTransaksiRef().onValue.map((event) {
      if (event.snapshot.value == null) {
        return [];  // Jika tidak ada data, kembalikan list kosong
      }

      if (event.snapshot.value is Map) {
        print('Data is Map');

        final data = event.snapshot.value as Map<dynamic, dynamic>;

        return data.entries
            .map((entry) {
              final key = entry.key as String;
              final transaksiJson = entry.value;

              if (transaksiJson == null) return null;

              final transaksiMap = Map<String, dynamic>.from(transaksiJson);

              // Convert ke TransaksiEntity
              final entity = TransaksiModel.fromJson({
                ...transaksiMap,
                "id": key
              }).toEntity();

              print("Entity: ${entity.id}");

              return entity;
            })
            .whereType<TransaksiEntity>()
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
              final transaksiJson = entry.value;

              if (transaksiJson == null) return null;

              final transaksiMap = Map<String, dynamic>.from(transaksiJson as Map);

              final entity = TransaksiModel.fromJson({
                ...transaksiMap,
                "id": index.toString()
              }).toEntity();

              // Debug: Print Entity
              print("Entity: ${entity.id}");

              return entity;
            })
            .whereType<TransaksiEntity>()
            .toList();
      }

      return [];
    });
  } catch (e) {
    return Stream.error(e);
  }
}

}