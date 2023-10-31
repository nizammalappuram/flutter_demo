class User {
  final int id;
  final String username;
  final String message;
  final List<String> roles;

  User({
    required this.id,
    required this.username,
    required this.message,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? -1,
      username: json['username'] ?? 'Error',
      message: json['message'] ?? 'Failed to process the request',
      roles: List<String>.from(json['roles'] ?? []),
    );
  }
}
