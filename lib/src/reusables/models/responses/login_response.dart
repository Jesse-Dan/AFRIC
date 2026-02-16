import 'package:equatable/equatable.dart';
import 'package:wallet/src/reusables/models/authorization.dart';
import 'package:wallet/src/reusables/models/user.dart';

class LoginResponse extends Equatable {
  const LoginResponse({required this.user, required this.authorization});

  final User? user;
  static const String userKey = "user";

  final Authorization? authorization;
  static const String authorizationKey = "authorization";

  LoginResponse copyWith({User? user, Authorization? authorization}) {
    return LoginResponse(
      user: user ?? this.user,
      authorization: authorization ?? this.authorization,
    );
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      authorization: json["authorization"] == null
          ? null
          : Authorization.fromJson(json["authorization"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "authorization": authorization?.toJson(),
  };

  @override
  String toString() {
    return "$user, $authorization, ";
  }

  @override
  List<Object?> get props => [user, authorization];
}
