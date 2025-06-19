class Level {
  final int id_level;
  // final int id_mataPelajaran;
  final String penjelasan_level;

  Level({
    required this.id_level,
    // required this.id_mataPelajaran,
    required this.penjelasan_level,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id_level: json['id_level'],
      // id_mataPelajaran: json['id_mataPelajaran'],
      penjelasan_level: json['penjelasan_level'],
    );
  }
}
