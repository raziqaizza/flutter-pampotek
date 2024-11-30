class TransaksiEntity {
  final String id;
  final String namaObat;
  final int jumlahObat;
  final int hargaObat;
  final DateTime tanggal;

  TransaksiEntity(
      {required this.id,
      required this.namaObat,
      required this.jumlahObat,
      required this.hargaObat,
      required this.tanggal});
}
