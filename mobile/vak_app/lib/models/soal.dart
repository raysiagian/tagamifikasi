// class Soal {
//   final int id_soal;
//   final int id_topik;
//   final String tipeSoal;
//   final String? media;
//   final String? pertanyaan;
//   final String? audioPertanyaan;
//   final String? opsiA;
//   final String? opsiB;
//   final String? opsiC;
//   final String? opsiD;
//   final String? pasanganA;
//   final String? pasanganB;
//   final String? pasanganC;
//   final String? pasanganD;
//   final String? jawabanBenar;

//   Soal({
//     required this.id_soal,
//     required this.id_topik,
//     required this.tipeSoal,
//     this.media,
//     this.pertanyaan,
//     this.audioPertanyaan,
//     this.opsiA,
//     this.opsiB,
//     this.opsiC,
//     this.opsiD,
//     this.pasanganA,
//     this.pasanganB,
//     this.pasanganC,
//     this.pasanganD,
//     this.jawabanBenar,
//   });

//   factory Soal.fromJson(Map<String, dynamic> json) {
//   return Soal(
//     id_soal: json['id_soal'],
//     id_topik: json['id_topik'],
//     tipeSoal: json['tipeSoal'],
//     media: json['media'],
//     pertanyaan: json['pertanyaan'],
//     audioPertanyaan: json['audioPertanyaan'],
//     opsiA: json['opsiA'] ?? "Opsi A",
//     opsiB: json['opsiB'] ?? "Opsi B",
//     opsiC: json['opsiC'] ?? "Opsi C",
//     opsiD: json['opsiD'] ?? "Opsi D",
//     pasanganA: json['pasanganA'] ?? "Pasangan A",
//     pasanganB: json['pasanganB'] ?? "Pasangan B",
//     pasanganC: json['pasanganC'] ?? "Pasangan C",
//     pasanganD: json['pasanganD'] ?? "Pasangan D",
//     jawabanBenar: json['jawabanBenar'],
//   );
// }

// }

class Soal {
  final int id_soal;
  final int id_topik;
  final String tipeSoal;
  final String? media;
  final String? pertanyaan;
  final String? audioPertanyaan;
  final dynamic opsiA; // Diubah menjadi dynamic karena bisa String atau Map
  final dynamic opsiB;
  final dynamic opsiC;
  final dynamic opsiD;
  final String? pasanganA;
  final String? pasanganB;
  final String? pasanganC;
  final String? pasanganD;
  final String jawabanBenar; // Diubah menjadi non-nullable

  Soal({
    required this.id_soal,
    required this.id_topik,
    required this.tipeSoal,
    this.media,
    this.pertanyaan,
    this.audioPertanyaan,
    required this.opsiA,
    required this.opsiB,
    required this.opsiC,
    required this.opsiD,
    this.pasanganA,
    this.pasanganB,
    this.pasanganC,
    this.pasanganD,
    required this.jawabanBenar,
  });

  factory Soal.fromJson(Map<String, dynamic> json) {
    return Soal(
      id_soal: json['id_soal'] as int,
      id_topik: json['id_topik'] as int,
      tipeSoal: json['tipeSoal'] as String,
      media: json['media'] as String?,
      pertanyaan: json['pertanyaan'] as String?,
      audioPertanyaan: json['audioPertanyaan'] as String?,
      opsiA: json['opsiA'],
      opsiB: json['opsiB'],
      opsiC: json['opsiC'],
      opsiD: json['opsiD'],
      pasanganA: json['pasanganA'] as String?,
      pasanganB: json['pasanganB'] as String?,
      pasanganC: json['pasanganC'] as String?,
      pasanganD: json['pasanganD'] as String?,
      jawabanBenar: json['jawabanBenar'] as String,
    );
  }
}