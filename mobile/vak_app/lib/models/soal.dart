class Soal {
  final int id_Soal;
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
    required this.id_Soal,
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
      id_Soal: json['id_Soal'],
      id_level: json['id_level'],
      tipeSoal: json['tipeSoal'],
      media: json['media'], // Bisa null
      pertanyaan: json['pertanyaan'],
      audioPertanyaan: json['audioPertanyaan'],
      opsiA: json['opsiA'],
      opsiB: json['opsiB'],
      opsiC: json['opsiC'],
      opsiD: json['opsiD'],
      jawabanBenar: json['jawabanBenar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_Soal': id_Soal,
      'id_level': id_level,
      'tipeSoal': tipeSoal,
      'media': media,
      'pertanyaan': pertanyaan,
      'audioPertanyaan': audioPertanyaan,
      'opsiA': opsiA,
      'opsiB': opsiB,
      'opsiC': opsiC,
      'opsiD': opsiD,
      'jawabanBenar': jawabanBenar,
    };
  }
}

// Contoh daftar soal dengan media yang nullable
List<Soal> soalList = [
  Soal(
    id_Soal: 1,
    id_level: 1,
    tipeSoal: "visual",
    media: "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg",
    pertanyaan: "Apa warna langit?",
    audioPertanyaan: "audio/anjing.mp3",
    opsiA: "Merah",
    opsiB: "Biru",
    opsiC: "Kuning",
    opsiD: "Hijau",
    jawabanBenar: "Biru",
  ),
  Soal(
    id_Soal: 2,
    id_level: 1,
    tipeSoal: "auditory",
    media: "audio/anjing.mp3", // Tidak ada media
    pertanyaan: "Suara apa yang kamu dengar?",
    audioPertanyaan: "audio/anjing.mp3",
    opsiA: "Kucing",
    opsiB: "Anjing",
    opsiC: "Burung",
    opsiD: "Sapi",
    jawabanBenar: "Kucing",
  ),

  Soal(
    id_Soal: 3,
    id_level: 1,
    tipeSoal: "kinestetik",
    // media: null, // Tidak ada media
    // pertanyaan: "Suara apa yang kamu dengar?",
    // audioPertanyaan: "audio2.mp3",
    opsiA: "🐈",
    opsiB: "🐕",
    opsiC: "🐜",
    opsiD: "🐄",
    pasanganA: "Kucing",
    pasanganB: "Anjing",
    pasanganC: "Semut",
    pasanganD: "Sapi",
    jawabanBenar: "Kucing",
  ),
];
