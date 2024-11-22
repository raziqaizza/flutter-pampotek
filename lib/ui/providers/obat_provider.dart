import 'package:flutter/material.dart';
import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';
import 'package:flutter_pampotek/domain/usecases/add_obat.dart';
import 'package:flutter_pampotek/domain/usecases/delete_obat.dart';
import 'package:flutter_pampotek/domain/usecases/get_obat.dart';

class ObatProvider extends ChangeNotifier {
  final AddObat addObatUseCase;
  final GetObat getObatUseCase;
  final DeleteObat deleteObatUseCase; // Tambahkan use case untuk delete

  List<ObatEntitiy> obats = [];

  ObatProvider({
    required this.addObatUseCase,
    required this.getObatUseCase,
    required this.deleteObatUseCase,
  });

  void fetchObat() {
    getObatUseCase().listen((data) {
      obats = data;
      notifyListeners();
    });
  }

  Future<void> addObat(ObatEntitiy obat) async {
    await addObatUseCase(obat);
  }

  Future<void> deleteObat(String id) async {
    await deleteObatUseCase(id); // Panggil use case deleteNote
    notifyListeners();
  }
}
