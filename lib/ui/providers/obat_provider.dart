import 'package:flutter/material.dart';
import 'package:flutter_pampotek/domain/entities/obat_entity.dart';
import 'package:flutter_pampotek/domain/usecases/add_obat.dart';
import 'package:flutter_pampotek/domain/usecases/delete_obat.dart';
import 'package:flutter_pampotek/domain/usecases/get_obat.dart';
import 'package:flutter_pampotek/domain/usecases/update_obat.dart';

class ObatProvider extends ChangeNotifier {
  final AddObat addObatUseCase;
  final GetObat getObatUseCase;
  final DeleteObat deleteObatUseCase; 
  final EditObat editObatUseCase; 

  List<ObatEntity> obats = [];

  ObatProvider({
    required this.addObatUseCase,
    required this.getObatUseCase,
    required this.deleteObatUseCase,
    required this.editObatUseCase, 
  });

  void fetchObat() {
    print('obat provider');
    getObatUseCase().listen((data) {
      obats = data;
      notifyListeners();
    });
  }

  Future<void> addObat(ObatEntity obat) async {
    await addObatUseCase(obat); // Panggil use case 
  }

  Future<void> editObat(ObatEntity obat) async {
    await editObatUseCase(obat);
  }
  
  Future<void> deleteObat(String id) async {
    await deleteObatUseCase(id); 
    notifyListeners();
  }
}
