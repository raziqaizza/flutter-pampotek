import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';
import 'package:flutter_pampotek/domain/repositories/obat_repository.dart';

class GetObat {
  final ObatRepository repository;

  GetObat(this.repository);

  Stream<List<ObatEntitiy>> call() {
    return repository.getObat();
  }
}