import 'package:flutter_pampotek/domain/entities/transaksi_entity.dart';
import 'package:flutter_pampotek/domain/repositories/transaksi_repository.dart';

class GetTransaksi {
  final TransaksiRepository repository;

  GetTransaksi(this.repository);

  Stream<List<TransaksiEntity>> call() {
    return repository.getTransaksi();
  }
}