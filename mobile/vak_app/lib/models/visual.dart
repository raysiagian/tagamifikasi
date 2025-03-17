class Visual{
  final int id_visual;
  final int id_soal;
  final String tipeSoal;
  final String gambar;
  final String pertanyaan;
  final String audioPertanyaan;
  final String? opsiA;
  final String? opsiB;
  final String? opsiC;
  final String? opsiD;
  final String jawabanBenar;

  Visual({
    required this.id_visual,
    required this.id_soal,
    required this.tipeSoal,
    required this.gambar,
    required this.pertanyaan,
    required this.audioPertanyaan,
    this.opsiA,
    this.opsiB,
    this.opsiC,
    this.opsiD,
    required this.jawabanBenar,
  });

  factory Visual.fromJson(Map<String,dynamic>json){
    return Visual(
      id_visual: json['id_visual'],
      id_soal: json['id_soal'], 
      tipeSoal: json['tipeSoal'], 
      gambar: json[''],
      pertanyaan: json['pertanyaan'],
      audioPertanyaan: json['audioPertanyaan'],
      opsiA: json['opsiA'],
      opsiB: json['opsiB'],
      opsiC: json['opsiC'],
      opsiD: json['opsiD'],
      jawabanBenar: json['jawabanBenar'],
    );
  }
}


List<Visual> visualList = [
  Visual(
    id_visual: 1,
    id_soal: 1,
    tipeSoal: "Visual",
    gambar: "",
    pertanyaan: "Berapa hasil 2 + 2?",
    audioPertanyaan: "",
    opsiA: "3",
    opsiB: "4",
    opsiC: "5",
    opsiD: "6",
    jawabanBenar: "4",
  ),
];