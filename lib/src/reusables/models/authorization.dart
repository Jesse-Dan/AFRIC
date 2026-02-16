import 'package:equatable/equatable.dart';

class Authorization extends Equatable {
  const Authorization({required this.token, required this.type});

  final String? token;
  static const String tokenKey = "token";

  final String? type;
  static const String typeKey = "type";

  Authorization copyWith({String? token, String? type}) {
    return Authorization(token: token ?? this.token, type: type ?? this.type);
  }

  factory Authorization.fromJson(Map<String, dynamic> json) {
    return Authorization(token: json["token"], type: json["type"]);
  }

  Map<String, dynamic> toJson() => {"token": token, "type": type};

  @override
  String toString() {
    return "$token, $type, ";
  }

  @override
  List<Object?> get props => [token, type];
}
