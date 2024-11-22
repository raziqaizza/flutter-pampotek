import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pampotek/data/models/obat_model.dart';
import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';
import 'package:flutter_pampotek/domain/repositories/obat_repository.dart';
import 'package:firebase_database/firebase_database.dart';

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
  Stream<List<ObatEntitiy>> getObat() {
    try {
      final uid = _getCurrentUserId();

      if (uid == null) {
        return Stream.value([]);
      }
      return _getObatRef().onValue.map((event) {
        if (event.snapshot.value == null) {
          return [];
        }

        if (event.snapshot.value is List<dynamic>) {
          final data = event.snapshot.value as List<dynamic>;
          return data.where((e) => e != null).map((e) {
            final obatJson = Map<String, dynamic>.from(e);
            return ObatModel.fromJson(obatJson).toEntity();
          }).toList();
        }
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
      rethrow;
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
