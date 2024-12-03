import 'package:flutter_pampotek/domain/entities/obat_entity.dart';
import 'package:flutter_pampotek/domain/repositories/obat_repository.dart';

class GetObat {
  final ObatRepository repository;

  GetObat(this.repository);

  Stream<List<ObatEntity>> call() {
    return repository.getObat();
  }
}