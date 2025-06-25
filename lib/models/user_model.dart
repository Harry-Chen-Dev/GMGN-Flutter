class User {
  final String id;
  final String email;
  final String username;
  final String? avatarUrl;
  final DateTime createdAt;
  final bool isVerified;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.avatarUrl,
    required this.createdAt,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      avatarUrl: json['avatarUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt.toIso8601String(),
      'isVerified': isVerified,
    };
  }
}
