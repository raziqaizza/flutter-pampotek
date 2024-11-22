import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';

class ObatModel {
  final String id;
  final String namaObat;
  final String deskripsiObat;
  final String jumlahObat;

  ObatModel(
      {required this.id,
      required this.namaObat,
      required this.deskripsiObat,
      required this.jumlahObat});

  factory ObatModel.fromJson(Map<String, dynamic> json) {
    return ObatModel(
      id: json['id'],
      namaObat: json['namaObat'],
      deskripsiObat: json['deskripsiObat'],
      jumlahObat: json['jumlahObat'],
    );
  }

  // Konversi NoteModel ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaObat': namaObat,
      'deskripsiObat': deskripsiObat,
      'jumlahObat': jumlahObat,
    };
  }

  // Konversi NoteModel ke NoteEntity
  ObatEntitiy toEntity() {
    return ObatEntitiy(
      id : id,
      namaObat: namaObat,
      deskripsiObat: deskripsiObat,
      jumlahObat: jumlahObat,
    );
  }

  // Konversi NoteEntity ke NoteModel
  static ObatModel fromEntity(ObatEntitiy entity) {
    return ObatModel(
      id : entity.id,
      namaObat: entity.namaObat,
      deskripsiObat: entity.deskripsiObat,
      jumlahObat: entity.jumlahObat,
    );
  }
}
