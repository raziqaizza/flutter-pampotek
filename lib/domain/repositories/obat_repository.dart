import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';

abstract class ObatRepository {
  Future<void> addObat(ObatEntitiy obat);
  Future<void> editObat(ObatEntitiy obat);
  Future<void> deleteObat(String id);
  Stream<List<ObatEntitiy>> getObat();
}