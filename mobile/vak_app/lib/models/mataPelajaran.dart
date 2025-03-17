class MataPelajaran {
  final int id_mataPelajaran;
  final String nama_mataPelajaran;

  MataPelajaran({
    required this.id_mataPelajaran,
    required this.nama_mataPelajaran,
  });

  factory MataPelajaran.fromJson(Map<String,dynamic>json){
    return MataPelajaran(
      id_mataPelajaran: json['id_mataPelajaran'], 
      nama_mataPelajaran: json['nama_mataPelajaran'],
    );
  }
}

// Dummy Data
List<MataPelajaran> mataPelajaranList = [
  MataPelajaran(id_mataPelajaran: 1, nama_mataPelajaran: "Matematika"),
  MataPelajaran(id_mataPelajaran: 2, nama_mataPelajaran: "Bahasa Indonesia"),
];