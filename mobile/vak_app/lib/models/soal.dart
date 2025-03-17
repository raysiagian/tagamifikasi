class Soal{
  final int id_soal;
  final int id_level;
  final String tipeSoal;

  Soal({
    required this.id_soal,
    required this.id_level,
    required this.tipeSoal,
  });

  factory Soal.fromJson(Map<String,dynamic>json){
    return Soal(
      id_soal: json['id_soal'],
      id_level: json['id_level'],
      tipeSoal: json['tipeSoal'],
    );
  }
}

List<Soal> soalList = [
  Soal(id_soal: 1, id_level: 1, tipeSoal: "Visual"),
  Soal(id_soal: 2, id_level: 1, tipeSoal: "Auditory"),
];