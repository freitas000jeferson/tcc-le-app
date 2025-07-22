class RegisterUserDtoResponse {
  String id;
  String email;
  String username;
  RegisterUserDtoResponse({
    required this.id,
    required this.email,
    required this.username,
  });

  factory RegisterUserDtoResponse.fromJson(Map<String, dynamic> json) =>
      RegisterUserDtoResponse(
        id: json['id'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
      );
}

class RegisterUserDtoRequest {
  String email;
  String username;
  String avatar;
  String password;
  String confirmPassword;
  RegisterUserDtoRequest({
    required this.email,
    required this.username,
    required this.avatar,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterUserDtoRequest.fromJson(Map<String, dynamic> json) =>
      RegisterUserDtoRequest(
        email: json['email'] as String,
        username: json['username'] as String,
        avatar: json['avatar'] as String,
        password: json['password'] as String,
        confirmPassword: json['confirmPassword'] as String,
      );

  Map<String, dynamic> toJson() => {
    'email': email,
    'username': username,
    'avatar': avatar,
    'password': password,
    'confirmPassword': confirmPassword,
  };
}
