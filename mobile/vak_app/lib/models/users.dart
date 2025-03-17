class Users {
  final int id_user;
  final String role;
  final String name;
  final String username;
  final String gender;
  final String created_at;
  final String updated_at;

  Users({
    required this.id_user,
    required this.role,
    required this.name,
    required this.username,
    required this.gender,
    required this.created_at,
    required this.updated_at,
  });

  factory Users.fromJson(Map<String,dynamic>json){
    return Users(
      id_user: json['id_user'] as int, 
      role: json['role'] as String, 
      name: json['name'] as String, 
      username: json['username'] as String, 
      gender: json['gender'] as String, 
      created_at: json['created_at'] as String, 
      updated_at: json['updated_at'] as String,
    );
  }
}

