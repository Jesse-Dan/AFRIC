import 'package:equatable/equatable.dart';
import 'package:wallet/src/reusables/models/user.dart';

class RegisterResponse extends Equatable {
  const RegisterResponse({required this.message, required this.user});

  final String? message;
  static const String messageKey = "message";

  final User? user;
  static const String userKey = "user";

  RegisterResponse copyWith({String? message, User? user}) {
    return RegisterResponse(
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {"message": message, "user": user?.toJson()};

  @override
  String toString() {
    return "$message, $user, ";
  }

  @override
  List<Object?> get props => [message, user];
}
