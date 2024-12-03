import 'package:flutter_pampotek/domain/entities/obat_entity.dart';

abstract class ObatRepository {
  Future<void> addObat(ObatEntity obat);
  Future<void> editObat(ObatEntity obat);
  Future<void> deleteObat(String id);
  Stream<List<ObatEntity>> getObat();
}