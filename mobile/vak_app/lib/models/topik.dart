class Topik {
  final int id_topik;
  final int id_level;
  final String nama_topik;

  Topik({
    required this.id_topik,
    required this.id_level,
    required this.nama_topik,
  });

  factory Topik.fromJson(Map<String, dynamic> json) {
    return Topik(
      id_topik: json['id_topik'],
      id_level: json['id_level'],
      nama_topik: json['nama_topik'],
    );
  }
}
