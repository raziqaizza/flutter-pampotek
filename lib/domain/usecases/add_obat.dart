import 'package:flutter_pampotek/domain/entities/obat_entity.dart';
import 'package:flutter_pampotek/domain/repositories/obat_repository.dart';

class AddObat {
  final ObatRepository repository;

  AddObat(this.repository);

  Future<void> call(ObatEntity obat) {
    return repository.addObat(obat);
  }
}