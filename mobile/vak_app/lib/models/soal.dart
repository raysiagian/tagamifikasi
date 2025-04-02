import 'dart:convert';

class SoalResponse {
  final String status;
  final String mataPelajaran;
  final String level;
  final List<Soal> soal;

  SoalResponse({
    required this.status,
    required this.mataPelajaran,
    required this.level,
    required this.soal,
  });

  factory SoalResponse.fromJson(String str) =>
      SoalResponse.fromMap(json.decode(str));

  factory SoalResponse.fromMap(Map<String, dynamic> json) => SoalResponse(
        status: json["status"],
        mataPelajaran: json["mataPelajaran"],
        level: json["level"],
        soal:
            List<Soal>.from(json["soal"].map((x) => Soal.fromMap(x))),
      );
}

class Soal {
  final int idSoal;
  final int idLevel;
  final String tipeSoal;
  final String? media;
  final String pertanyaan;
  final String? audioPertanyaan;
  final String opsiA;
  final String opsiB;
  final String opsiC;
  final String opsiD;
  final String jawabanBenar;

  Soal({
    required this.idSoal,
    required this.idLevel,
    required this.tipeSoal,
    this.media,
    required this.pertanyaan,
    this.audioPertanyaan,
    required this.opsiA,
    required this.opsiB,
    required this.opsiC,
    required this.opsiD,
    required this.jawabanBenar,
  });

  factory Soal.fromJson(String str) => Soal.fromMap(json.decode(str));

  factory Soal.fromMap(Map<String, dynamic> json) => Soal(
        idSoal: json["id_soal"],
        idLevel: json["id_level"],
        tipeSoal: json["tipeSoal"],
        media: json["media"],
        pertanyaan: json["pertanyaan"],
        audioPertanyaan: json["audioPertanyaan"],
        opsiA: json["opsiA"],
        opsiB: json["opsiB"],
        opsiC: json["opsiC"],
        opsiD: json["opsiD"],
        jawabanBenar: json["jawabanBenar"],
      );
}