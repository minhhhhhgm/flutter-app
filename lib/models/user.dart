class User {
  final String password;
  final String? name; 
  final String email;

  User({
    required this.password,
    this.name, 
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      password: json['password'],
      name: json['name'], 
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'name': name, 
      'email': email,
    };
  }
}
