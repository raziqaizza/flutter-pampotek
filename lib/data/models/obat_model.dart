import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';

class ObatModel {
  final String id;
  final String namaObat;
  final String deskripsiObat;
  final int jumlahObat;
  final int hargaObat;

  ObatModel(
      {required this.id,
      required this.namaObat,
      required this.deskripsiObat,
      required this.jumlahObat,
      required this.hargaObat});

  factory ObatModel.fromJson(Map<String, dynamic> json) {
    return ObatModel(
      id: json['id'],
      namaObat: json['namaObat'],
      deskripsiObat: json['deskripsiObat'],
      jumlahObat: json['jumlahObat'],
      hargaObat: json['hargaObat']
    );
  }

  // Konversi NoteModel ke JSON
  Map<String, dynamic> toJson() {
    return {
      'namaObat': namaObat,
      'deskripsiObat': deskripsiObat,
      'jumlahObat': jumlahObat,
      'hargaObat': hargaObat
    };
  }

  // Konversi NoteModel ke NoteEntity
  ObatEntitiy toEntity() {
    return ObatEntitiy(
      id : id,
      namaObat: namaObat,
      deskripsiObat: deskripsiObat,
      jumlahObat: jumlahObat,
      hargaObat: hargaObat,
    );
  }

  // Konversi NoteEntity ke NoteModel
  static ObatModel fromEntity(ObatEntitiy entity) {
    return ObatModel(
      id : entity.id,
      namaObat: entity.namaObat,
      deskripsiObat: entity.deskripsiObat,
      jumlahObat: entity.jumlahObat,
      hargaObat: entity.hargaObat,
    );
  }
}
