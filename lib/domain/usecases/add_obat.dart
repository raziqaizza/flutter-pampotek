import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';
import 'package:flutter_pampotek/domain/repositories/obat_repository.dart';

class AddObat {
  final ObatRepository repository;

  AddObat(this.repository);

  Future<void> call(ObatEntitiy obat) {
    return repository.addObat(obat);
  }
}