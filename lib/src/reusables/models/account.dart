import 'package:equatable/equatable.dart';

class Account extends Equatable {
  const Account({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  static const String idKey = "id";

  final String? userId;
  static const String userIdKey = "user_id";

  final String? accountNumber;
  static const String accountNumberKey = "account_number";

  final String? balance;
  static const String balanceKey = "balance";

  final String? currency;
  static const String currencyKey = "currency";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updated_at";

  Account copyWith({
    int? id,
    String? userId,
    String? accountNumber,
    String? balance,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountNumber: accountNumber ?? this.accountNumber,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json["id"],
      userId: json["user_id"],
      accountNumber: json["account_number"],
      balance: json["balance"],
      currency: json["currency"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "account_number": accountNumber,
    "balance": balance,
    "currency": currency,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return "$id, $userId, $accountNumber, $balance, $currency, $createdAt, $updatedAt, ";
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    accountNumber,
    balance,
    currency,
    createdAt,
    updatedAt,
  ];
}
