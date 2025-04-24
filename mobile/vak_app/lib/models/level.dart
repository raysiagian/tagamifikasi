class Level {
  final int id_level;
  final int id_mataPelajaran;
  final String penjelasan_level;

  Level({
    required this.id_level,
    required this.id_mataPelajaran,
    required this.penjelasan_level,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id_level: json['id_level'],
      id_mataPelajaran: json['id_mataPelajaran'],
      penjelasan_level: json['penjelasan_level'],
    );
  }
}

List<Level> level = [
  Level(id_level: 1, id_mataPelajaran: 1, penjelasan_level: 'pengenalan angka'),
  Level(
      id_level: 2, id_mataPelajaran: 1, penjelasan_level: 'pengenalan angka 2'),
];

// import 'mataPelajaran.dart';

// class Level {
//   final int idLevel;
//   final int idMataPelajaran;
//   final String penjelasanLevel;
//   final MataPelajaran mataPelajaran;

//   Level({
//     required this.idLevel,
//     required this.idMataPelajaran,
//     required this.penjelasanLevel,
//     required this.mataPelajaran,
//   });

//   factory Level.fromJson(Map<String, dynamic> json) {
//     return Level(
//       idLevel: json['id_level'],
//       idMataPelajaran: json['id_mataPelajaran'],
//       penjelasanLevel: json['penjelasan_level'],
//       mataPelajaran: MataPelajaran.fromJson(json['mata_pelajaran']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id_level': idLevel,
//       'id_mataPelajaran': idMataPelajaran,
//       'penjelasan_level': penjelasanLevel,
//       'mata_pelajaran': mataPelajaran.toJson(), //
//     };
//   }
// }