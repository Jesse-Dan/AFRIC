import 'package:equatable/equatable.dart';

class JournalEntry extends Equatable {
  const JournalEntry({required this.amount});

  final int? amount;
  static const String amountKey = "amount";

  JournalEntry copyWith({int? amount}) {
    return JournalEntry(amount: amount ?? this.amount);
  }

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(amount: json["amount"]);
  }

  Map<String, dynamic> toJson() => {"amount": amount};

  @override
  String toString() {
    return "$amount, ";
  }

  @override
  List<Object?> get props => [amount];
}
