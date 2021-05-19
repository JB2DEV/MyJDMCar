class UserModel {
  final int id;
  final String email;
  String accessToken;
  String userName;

  UserModel({this.id, this.email, this.accessToken, this.userName});

  UserModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'] as int ?? null,
        this.email = parsedJson['email'] ?? null,
        this.accessToken = parsedJson['token'] ?? null,
        this.userName = parsedJson['userName'] ?? null;

  Map<String, dynamic> toJson() => {
        'id': id ?? null,
        'accessToken': accessToken ?? null,
        'name': userName ?? null,
        'email': email ?? null
      };
}
