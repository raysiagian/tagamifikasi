class Users {
  final int idUser;
  final String role;
  final String name;
  final String username;
  final String gender;
  final String tanggalLahir; // Tambahkan ini

  Users({
    required this.idUser,
    required this.role,
    required this.name,
    required this.username,
    required this.gender,
    required this.tanggalLahir, // Tambahkan ini
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      idUser: json['id_user'],
      role: json['role'],
      name: json['name'],
      username: json['username'],
      gender: json['gender'],
      tanggalLahir: json['tanggal_lahir'], // Parsing tanggal lahir
    );
  }
}
