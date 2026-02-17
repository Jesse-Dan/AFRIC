import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TransactionItem extends Equatable {
  final String name;
  final String date;
  final IconData icon;
  final String amount;
  final bool isCredit;

  const TransactionItem({
    required this.name,
    required this.date,
    required this.icon,
    required this.amount,
    required this.isCredit,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      name: json['name'] as String,
      date: json['date'] as String,
      icon: IconData(json['icon_code'] as int, fontFamily: 'MaterialIcons'),
      amount: json['amount'] as String,
      isCredit: json['is_credit'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'icon_code': icon.codePoint,
      'amount': amount,
      'is_credit': isCredit,
    };
  }

  @override
  List<Object?> get props => [name, date, icon, amount, isCredit];
}
