class Level {
  final int id_level;
  final String nama_level;

  Level({
    required this.id_level,
    required this.nama_level,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id_level: json['id_level'],
      nama_level: json['nama_level'],
    );
  }
}
