import 'package:flutter_pampotek/domain/entities/obat_entity.dart';
import 'package:flutter_pampotek/domain/repositories/obat_repository.dart';

class EditObat {
  final ObatRepository repository;

  EditObat(this.repository);

  Future<void> call(ObatEntity obat) {
    return repository.editObat(obat);
  }
}