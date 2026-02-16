import 'package:equatable/equatable.dart';
import 'package:wallet/src/reusables/models/account_journal.dart';

class Journal extends Equatable {
  const Journal({required this.message, required this.accountJournal});

  final String? message;
  static const String messageKey = "message";

  final AccountJournal? accountJournal;
  static const String accountJournalKey = "account_journal";

  Journal copyWith({String? message, AccountJournal? accountJournal}) {
    return Journal(
      message: message ?? this.message,
      accountJournal: accountJournal ?? this.accountJournal,
    );
  }

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      message: json["message"],
      accountJournal: json["account_journal"] == null
          ? null
          : AccountJournal.fromJson(json["account_journal"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "account_journal": accountJournal?.toJson(),
  };

  @override
  String toString() {
    return "$message, $accountJournal, ";
  }

  @override
  List<Object?> get props => [message, accountJournal];
}
