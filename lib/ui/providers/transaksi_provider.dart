import 'package:flutter/material.dart';
import 'package:flutter_pampotek/domain/entities/transaksi_entity.dart';
import 'package:flutter_pampotek/domain/usecases/add_transaksi.dart';
import 'package:flutter_pampotek/domain/usecases/delete_transaksi.dart';
import 'package:flutter_pampotek/domain/usecases/get_transaksi.dart';

class TransaksiProvider extends ChangeNotifier {
  final AddTransaksi addTransaksiUseCase;
  final DeleteTransaksi deleteTransaksiUseCase;
  final GetTransaksi getTransaksiUseCase;

  List<TransaksiEntity> transaksi = [];

  TransaksiProvider({
    required this.addTransaksiUseCase,
    required this.deleteTransaksiUseCase,
    required this.getTransaksiUseCase,
  });

  void fetchTransaksi() {
    getTransaksiUseCase().listen((data) {
      transaksi = data;
      notifyListeners();
    });
  }

  Future<void> addTransaksi(TransaksiEntity transaksi) async {
    await addTransaksiUseCase(transaksi);
  }
  
  Future<void> deleteTransaksi(String id) async {
    await deleteTransaksiUseCase(id);
  }
}
