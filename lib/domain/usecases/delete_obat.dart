import 'package:flutter_pampotek/domain/repositories/obat_repository.dart';

class DeleteObat {
  final ObatRepository repository;

  DeleteObat(this.repository);

  Future<void> call(String id) {
    return repository.deleteObat(id);
  }
}