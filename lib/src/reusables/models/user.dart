import 'package:equatable/equatable.dart';
import 'package:wallet/src/reusables/models/account.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.account,
  });

  final int? id;
  static const String idKey = "id";

  final String? name;
  static const String nameKey = "name";

  final String? email;
  static const String emailKey = "email";

  final DateTime? emailVerifiedAt;
  static const String emailVerifiedAtKey = "email_verified_at";

  final String? currency;
  static const String currencyKey = "currency";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updated_at";

  final Account? account;
  static const String accountKey = "account";

  User copyWith({
    int? id,
    String? name,
    String? email,
    DateTime? emailVerifiedAt,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    Account? account,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      account: account ?? this.account,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
      currency: json["currency"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      account: json["account"] == null
          ? null
          : Account.fromJson(json["account"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "currency": currency,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "account": account?.toJson(),
  };

  @override
  String toString() {
    return "$id, $name, $email, $emailVerifiedAt, $currency, $createdAt, $updatedAt, $account, ";
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    emailVerifiedAt,
    currency,
    createdAt,
    updatedAt,
    account,
  ];
}
