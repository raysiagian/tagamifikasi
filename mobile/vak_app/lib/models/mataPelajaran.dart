class MataPelajaran {
  final int id;
  final String nama;
  final String iconPath;

  MataPelajaran({
    required this.id,
    required this.nama, 
    required this.iconPath,
  });

  factory MataPelajaran.fromJson(Map<String, dynamic> json) {
    // Mapping ikon berdasarkan nama mata pelajaran
    const Map<String, String> iconMapping = {
      "Komunikasi": "assets/images/component/HiFi-Komunikasi Subject Icon.png",
      "Bahasa Indonesia":"assets/images/component/HiFi-Bahasa Indonesia Subject Icon.png",
      // "English": "assets/images/component/HiFi-Bahasa Inggris Subject Icon.png",
      "Sains": "assets/images/component/HiFi-Sains Subject Icon.png",
      "Matematika": "assets/images/component/HiFi-Matematika Subject Icon.png",
    };

    return MataPelajaran(
      id: json['id_mataPelajaran'],
      nama: json['nama_mataPelajaran'],
      iconPath: iconMapping[json['nama_mataPelajaran']] ??
          "assets/images/default_icon.png",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_mataPelajaran': id,
      'nama_mataPelajaran': nama,
      'iconPath': iconPath,  
    };
  }
}