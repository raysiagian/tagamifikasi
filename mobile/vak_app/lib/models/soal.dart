class Soal {
  final int id_soal;
  final int id_level;
  final String tipeSoal;
  final String? media;
  final String? pertanyaan;
  final String? audioPertanyaan;
  final String? opsiA;
  final String? opsiB;
  final String? opsiC;
  final String? opsiD;
  final String? pasanganA;
  final String? pasanganB;
  final String? pasanganC;
  final String? pasanganD;
  final String? jawabanBenar;

  Soal({
    required this.id_soal,
    required this.id_level,
    required this.tipeSoal,
    this.media,
    this.pertanyaan,
    this.audioPertanyaan,
    this.opsiA,
    this.opsiB,
    this.opsiC,
    this.opsiD,
    this.pasanganA,
    this.pasanganB,
    this.pasanganC,
    this.pasanganD,
    this.jawabanBenar,
  });

  factory Soal.fromJson(Map<String, dynamic> json) {
  return Soal(
    id_soal: json['id_soal'],
    id_level: json['id_level'],
    tipeSoal: json['tipeSoal'],
    media: json['media'],
    pertanyaan: json['pertanyaan'],
    audioPertanyaan: json['audioPertanyaan'],
    opsiA: json['opsiA'] ?? "Opsi A",
    opsiB: json['opsiB'] ?? "Opsi B",
    opsiC: json['opsiC'] ?? "Opsi C",
    opsiD: json['opsiD'] ?? "Opsi D",
    pasanganA: json['pasanganA'] ?? "Pasangan A",
    pasanganB: json['pasanganB'] ?? "Pasangan B",
    pasanganC: json['pasanganC'] ?? "Pasangan C",
    pasanganD: json['pasanganD'] ?? "Pasangan D",
    jawabanBenar: json['jawabanBenar'],
  );
}

}