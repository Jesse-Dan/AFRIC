import 'package:equatable/equatable.dart';
import 'package:wallet/src/reusables/enums/direction.dart';

class AccountJournal extends Equatable {
  const AccountJournal({
    required this.accountId,
    required this.direction,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final int? accountId;
  static const String accountIdKey = "account_id";

  final Direction? direction;
  static const String directionKey = "direction";

  final int? amount;
  static const String amountKey = "amount";

  final String? balanceBefore;
  static const String balanceBeforeKey = "balance_before";

  final int? balanceAfter;
  static const String balanceAfterKey = "balance_after";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updated_at";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final int? id;
  static const String idKey = "id";

  AccountJournal copyWith({
    int? accountId,
    Direction? direction,
    int? amount,
    String? balanceBefore,
    int? balanceAfter,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) {
    return AccountJournal(
      accountId: accountId ?? this.accountId,
      direction: direction ?? this.direction,
      amount: amount ?? this.amount,
      balanceBefore: balanceBefore ?? this.balanceBefore,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  factory AccountJournal.fromJson(Map<String, dynamic> json) {
    return AccountJournal(
      accountId: json["account_id"],
      direction: DirectionExtension.fromJsonOrNull(json["direction"]),
      amount: json["amount"],
      balanceBefore: json["balance_before"],
      balanceAfter: json["balance_after"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "direction": direction?.toJson(),
    "amount": amount,
    "balance_before": balanceBefore,
    "balance_after": balanceAfter,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };

  @override
  String toString() {
    return "$accountId, $direction, $amount, $balanceBefore, $balanceAfter, $updatedAt, $createdAt, $id, ";
  }

  @override
  List<Object?> get props => [
    accountId,
    direction,
    amount,
    balanceBefore,
    balanceAfter,
    updatedAt,
    createdAt,
    id,
  ];
}
