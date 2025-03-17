class Level{
  final int id_level;
  final int id_mataPelajaran;
  final String penjelasanLevel;

  Level({
    required this.id_level,
    required this.id_mataPelajaran,
    required this.penjelasanLevel,
  });

  factory Level.fromJson(Map<String,dynamic>json){
    return Level(
      id_level: json['id_level'], 
      id_mataPelajaran: json['id_mataPelajaran'], 
      penjelasanLevel: json['penjelasanLevel'],
    );
  }
}

List<Level>level = [
  Level(id_level: 1, id_mataPelajaran: 1, penjelasanLevel: 'pengenalan angka'),
  Level(id_level: 2, id_mataPelajaran: 1, penjelasanLevel: 'pengenalan angka 2'),
];  