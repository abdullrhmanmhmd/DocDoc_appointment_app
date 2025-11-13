class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? gender;
  String? token;
  String? password;
  String? confirmPassword;


  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.gender,
    this.token,
    this.password,
    this.confirmPassword,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'] ?? json['username'] ?? '',
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    gender: json['gender'] ?? '',
    token: json['token'] ?? '',
    password: json['password'] ?? '',
    confirmPassword: json['password_confirmation'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'email': email,
    'phone': phone,
    'gender': gender,
    'token': token,
    'password': password,
    'password_confirmation': confirmPassword,
  };
}
