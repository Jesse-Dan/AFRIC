import 'package:flutter/material.dart';
import 'package:wallet/src/modules/home/components/section_header.dart';
import 'package:wallet/src/modules/home/components/transactions_list.dart';
import 'package:wallet/src/modules/home/model/transaction_item.dart';

class RecentTransactionsSection extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<TransactionItem> transactions;

  const RecentTransactionsSection({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(isExpanded: isExpanded, onToggle: onToggle),
        SizedBox(height: 16),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? TransactionsList(transactions: transactions)
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
