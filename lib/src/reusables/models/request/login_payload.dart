import 'package:equatable/equatable.dart';

class LoginPayload extends Equatable {
  const LoginPayload({required this.email, required this.password});

  final String? email;
  static const String emailKey = "email";

  final String? password;
  static const String passwordKey = "password";

  LoginPayload copyWith({String? email, String? password}) {
    return LoginPayload(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory LoginPayload.fromJson(Map<String, dynamic> json) {
    return LoginPayload(email: json["email"], password: json["password"]);
  }

  Map<String, dynamic> toJson() => {"email": email, "password": password};

  @override
  String toString() {
    return "$email, $password, ";
  }

  @override
  List<Object?> get props => [email, password];
}
