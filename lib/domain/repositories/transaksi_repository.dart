import 'package:flutter_pampotek/domain/entities/transaksi_entity.dart';

abstract class TransaksiRepository {
  Future<void> addTransaksi(TransaksiEntity transaksi);
  Future<void> deleteTransaksi(String id);
  Stream<List<TransaksiEntity>> getTransaksi();
}