import 'package:equatable/equatable.dart';

class RegisterPayload extends Equatable {
  const RegisterPayload({
    required this.name,
    required this.email,
    required this.currency,
    required this.password,
  });

  final String? name;
  static const String nameKey = "name";

  final String? email;
  static const String emailKey = "email";

  final String? currency;
  static const String currencyKey = "currency";

  final String? password;
  static const String passwordKey = "password";

  RegisterPayload copyWith({
    String? name,
    String? email,
    String? currency,
    String? password,
  }) {
    return RegisterPayload(
      name: name ?? this.name,
      email: email ?? this.email,
      currency: currency ?? this.currency,
      password: password ?? this.password,
    );
  }

  factory RegisterPayload.fromJson(Map<String, dynamic> json) {
    return RegisterPayload(
      name: json["name"],
      email: json["email"],
      currency: json["currency"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "currency": currency,
    "password": password,
  };

  @override
  String toString() {
    return "$name, $email, $currency, $password, ";
  }

  @override
  List<Object?> get props => [name, email, currency, password];
}
