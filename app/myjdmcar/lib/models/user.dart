class UserModel {
  final int id;
  final String email;
  String accessToken;
  String userName;
  String expDate;

  UserModel(
      {this.id, this.email, this.accessToken, this.userName, this.expDate});

  UserModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'] as int ?? null,
        this.email = parsedJson['email'] ?? null,
        this.accessToken = parsedJson['token'] ?? null,
        this.userName = parsedJson['userName'] ?? null,
        this.expDate = parsedJson['expDate'] ?? null;

  Map<String, dynamic> toJson() => {
        'id': id ?? null,
        'accessToken': accessToken ?? null,
        'name': userName ?? null,
        'email': email ?? null,
        'expDate': expDate ?? null
      };
}
