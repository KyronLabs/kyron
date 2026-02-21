class User {
  final String id;
  final String email;
  final String? username;
  final String? name;
  final String role;
  final String? did;
  final int kyronPoints;

  User({
    required this.id,
    required this.email,
    this.username,
    this.name,
    this.role = 'USER',
    this.did,
    this.kyronPoints = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String? ?? 'USER',
      did: json['did'] as String?, 
      kyronPoints: (json['kyronPoints'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'name': name,
      'role': role,
      'did': did,
      'kyronPoints': kyronPoints,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? name,
    String? role,
    String? did,
    int? kyronPoints,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      role: role ?? this.role,
      did: did ?? this.did,
      kyronPoints: kyronPoints ?? this.kyronPoints,
    );
  }
}