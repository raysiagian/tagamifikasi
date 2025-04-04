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
      id_soal: json['id_soal'], // Ubah ke format sesuai JSON
      id_level: json['id_level'],
      tipeSoal: json['tipeSoal'],
      media: json['media'],
      pertanyaan: json['pertanyaan'],
      audioPertanyaan: json['audioPertanyaan'],
      opsiA: json['opsiA'],
      opsiB: json['opsiB'],
      opsiC: json['opsiC'],
      opsiD: json['opsiD'],
      pasanganA: json['pasanganA'],
      pasanganB: json['pasanganB'],
      pasanganC: json['pasanganC'],
      pasanganD: json['pasanganD'],
      jawabanBenar: json['jawabanBenar'],
    );
  }
}
