class User {
  final int id; // Tambahkan properti id
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0, // Tambahkan id dari json
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  // Getter untuk mendapatkan nilai id
  int get getId => id;

  // Getter untuk mendapatkan nama lengkap
  String getFullName() {
    return '$firstName $lastName';
  }
}
