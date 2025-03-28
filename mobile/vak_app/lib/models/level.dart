import 'soal.dart';

class Level {
  final int idLevel;
  final int idMataPelajaran;
  final String penjelasanLevel;
  final String namaMataPelajaran;

  Level({
    required this.idLevel,
    required this.idMataPelajaran,
    required this.penjelasanLevel,
    required this.namaMataPelajaran,
  });

  // Konversi dari JSON ke Model
  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      idLevel: json['id_level'],
      idMataPelajaran: json['id_mataPelajaran'],
      penjelasanLevel: json['penjelasan_level'],
      namaMataPelajaran: json['mata_pelajaran']['nama_mataPelajaran'],
    );
  }
}

// Model untuk response level dan soal
class LevelSoalResponse {
  final String status;
  final String level;
  final List<Soal> soal;

  LevelSoalResponse({
    required this.status,
    required this.level,
    required this.soal,
  });

  factory LevelSoalResponse.fromJson(Map<String, dynamic> json) {
    return LevelSoalResponse(
      status: json["status"],
      level: json["level"],
      soal: (json["soal"] as List).map((item) => Soal.fromJson(item)).toList(),
    );
  }
}
