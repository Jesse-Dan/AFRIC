import 'package:flutter/material.dart';

class TransactionItem {
  final String name;
  final String date;
  final IconData icon;
  final String amount;
  final bool isCredit;

  TransactionItem({
    required this.name,
    required this.date,
    required this.icon,
    required this.amount,
    required this.isCredit,
  });
}
