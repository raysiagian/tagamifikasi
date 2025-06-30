class Topik {
  final int id_topik;
  final int id_level;
  final String nama_topik;
  final String icon;

  Topik({
    required this.id_topik,
    required this.id_level,
    required this.nama_topik,
    required this.icon,
  });

  factory Topik.fromJson(Map<String, dynamic> json) {
    return Topik(
      id_topik: json['id_topik'],
      id_level: json['id_level'],
      nama_topik: json['nama_topik'],
      icon: json['icon'],
    );
  }
}
