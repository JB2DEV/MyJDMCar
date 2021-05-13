class UserModel {
  final int id;
  final String email;
  String accessToken;
  final String userName;

  UserModel({this.id, this.email, this.accessToken, this.userName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return new UserModel(
      id: json['id'] as int,
      userName: json['userName'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'accessToken': accessToken, 'name': userName, 'email': email};
}
