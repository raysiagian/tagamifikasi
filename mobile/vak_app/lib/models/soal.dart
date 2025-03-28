class Soal {
  final int idSoal;
  final int idLevel;
  final String tipeSoal;
  final String media;
  final String pertanyaan;
  final String? audioPertanyaan;
  final String opsiA;
  final String opsiB;
  final String opsiC;
  final String opsiD;
  final String jawabanBenar;
  final DateTime createdAt;
  final DateTime updatedAt;

  Soal({
    required this.idSoal,
    required this.idLevel,
    required this.tipeSoal,
    required this.media,
    required this.pertanyaan,
    this.audioPertanyaan,
    required this.opsiA,
    required this.opsiB,
    required this.opsiC,
    required this.opsiD,
    required this.jawabanBenar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Soal.fromJson(Map<String, dynamic> json) {
    return Soal(
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
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
