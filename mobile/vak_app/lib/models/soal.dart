class Soal {
  final int id_soal;
  final int id_topik;
  final String tipeSoal;
  final String? media;
  final String? pertanyaan;
  final String? audioPertanyaan;
  final dynamic opsiA;
  final dynamic opsiB;
  final dynamic opsiC;
  final dynamic opsiD;
  final String? pasanganA;
  final String? pasanganB;
  final String? pasanganC;
  final String? pasanganD;
  final String jawabanBenar;

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
    // Handle potential null values for jawabanBenar
    final jawaban = json['jawabanBenar'];
    final String jawabanBenar;
    
    if (jawaban == null) {
      jawabanBenar = '';
    } else if (jawaban is String) {
      jawabanBenar = jawaban;
    } else {
      jawabanBenar = jawaban.toString();
    }

    return Soal(
      id_soal: json['id_soal'] as int? ?? 0, // Provide default if null
      id_topik: json['id_topik'] as int? ?? 0,
      tipeSoal: (json['tipeSoal'] as String?) ?? 'unknown',
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
      jawabanBenar: jawabanBenar,
    );
  }

  // Helper method to safely get options as String
  String getOptionA() => _convertOptionToString(opsiA);
  String getOptionB() => _convertOptionToString(opsiB);
  String getOptionC() => _convertOptionToString(opsiC);
  String getOptionD() => _convertOptionToString(opsiD);

  String _convertOptionToString(dynamic option) {
    if (option == null) return '';
    if (option is String) return option;
    if (option is Map) return option.toString();
    return option.toString();
  }
}