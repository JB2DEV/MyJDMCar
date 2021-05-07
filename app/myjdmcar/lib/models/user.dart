class User {
  final int id;
  final String email;
  String accessToken;
  final String name;

  User({this.id, this.email, this.accessToken, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'accessToken': accessToken, 'name': name, 'email': email};
}
