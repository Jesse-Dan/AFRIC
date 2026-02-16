import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/modules/home/components/transaction_list_item.dart';
import 'package:wallet/src/modules/home/model/transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<TransactionItem> transactions;

  const TransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorConfig.surfaceDark : ColorConfig.surfaceLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: transactions.isEmpty
          ? Padding(
              padding: EdgeInsets.all(40),
              child: Center(
                child: Text(
                  'No transactions found',
                  style: TextStyle(
                    color: ColorConfig.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(left: 72),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: isDark
                      ? ColorConfig.borderColorDark.withOpacity(0.3)
                      : ColorConfig.dividerColor.withOpacity(0.5),
                ),
              ),
              itemBuilder: (context, index) {
                return TransactionListItem(transaction: transactions[index]);
              },
            ),
    );
  }
}
