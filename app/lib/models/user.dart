class User {
  final String id;
  final String email;
  final String? username;
  final String? name;
  final String role;
  final String? did;

  User({
    required this.id,
    required this.email,
    this.username,
    this.name,
    this.role = 'USER',
    this.did,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String? ?? 'USER',
      did: json['did'] as String?,
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
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? name,
    String? role,
    String? did,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      role: role ?? this.role,
      did: did ?? this.did,
    );
  }
}
