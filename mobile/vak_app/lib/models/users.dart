class Users {
  final int id_user;
  final String role;
  final String name;
  final String username;
  final String gender;
  final String tanggalLahir;

  Users({
    required this.id_user,
    required this.role,
    required this.name,
    required this.username,
    required this.gender,
    required this.tanggalLahir,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id_user: json['id_user'],
      role: json['role'],
      name: json['name'],
      username: json['username'],
      gender: json['gender'],
      tanggalLahir: json['tanggal_lahir'],
    );
  }
}
