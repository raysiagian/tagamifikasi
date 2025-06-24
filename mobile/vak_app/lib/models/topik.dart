class Topik {
  final int id_topik;
  final int id_level;
  // final int id_mataPelajaran;
  final String penjelasan_level;

  Topik({
    required this.id_level,
    // required this.id_mataPelajaran,
    required this.penjelasan_level,
  });

  factory Topik.fromJson(Map<String, dynamic> json) {
    return Topik(
      id_level: json['id_level'],
      // id_mataPelajaran: json['id_mataPelajaran'],
      penjelasan_level: json['penjelasan_level'],
    );
  }
}
