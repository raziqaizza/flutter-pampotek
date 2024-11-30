import 'package:flutter_pampotek/domain/repositories/transaksi_repository.dart';

class DeleteTransaksi {
  final TransaksiRepository repository;

  DeleteTransaksi(this.repository);

  Future<void> call(String id) {
    return repository.deleteTransaksi(id);
  }
}