import 'package:flutter_pampotek/domain/entities/transaksi_entity.dart';

class TransaksiModel {
  final String id;
  final String namaObat;
  final int jumlahObat;
  final int hargaObat;
  final DateTime tanggal;

  TransaksiModel({
    required this.id,
    required this.namaObat,
    required this.jumlahObat,
    required this.hargaObat,
    required this.tanggal,
  });

  // Factory constructor untuk membuat objek dari JSON
  factory TransaksiModel.fromJson(Map<String, dynamic> json) {
    return TransaksiModel(
      id: json['id'],
      namaObat: json['namaObat'],
      jumlahObat: json['jumlahObat'],
      hargaObat: json['hargaObat'],
      tanggal: DateTime.parse(json['tanggal']),  // Parse tanggal
    );
  }

  // Konversi ke format JSON
  Map<String, dynamic> toJson() {
    return {
      'namaObat': namaObat,
      'jumlahObat': jumlahObat,
      'hargaObat': hargaObat,
      'tanggal': tanggal.toIso8601String(), // Format ISO untuk tanggal
    };
  }

  // Konversi dari model ke entity
  TransaksiEntity toEntity() {
    return TransaksiEntity(
      id: id,
      namaObat: namaObat,
      jumlahObat: jumlahObat,
      hargaObat: hargaObat,
      tanggal: tanggal,
    );
  }

  // Konversi dari entity ke model
  static TransaksiModel fromEntity(TransaksiEntity entity) {
    return TransaksiModel(
      id: entity.id,
      namaObat: entity.namaObat,
      jumlahObat: entity.jumlahObat,
      hargaObat: entity.hargaObat,
      tanggal: entity.tanggal,
    );
  }
}