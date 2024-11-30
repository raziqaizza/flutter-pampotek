import 'package:flutter_pampotek/domain/entities/transaksi_entity.dart';
import 'package:flutter_pampotek/domain/repositories/transaksi_repository.dart';

class AddTransaksi {
  final TransaksiRepository repository;

  AddTransaksi(this.repository);

  Future<void> call(TransaksiEntity transaksi) {
    return repository.addTransaksi(transaksi);
  }
}