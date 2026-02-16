import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/reusables/sheets/recieve_money_sheet.dart';
import 'package:wallet/src/reusables/sheets/send_money_sheet.dart';

class AppBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isDark ? ColorConfig.surfaceDark : Colors.white),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  static Future<double?> showSendFunds(BuildContext context) {
    return show<double>(context: context, child: SendFundsSheet());
  }

  static Future<double?> showReceiveFunds(BuildContext context) {
    return show<double>(context: context, child: ReceiveFundsSheet());
  }
}

class QuickAmountButtons extends StatelessWidget {
  final Function(double) onAmountSelected;

  const QuickAmountButtons({super.key, required this.onAmountSelected});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final amounts = [10.0, 50.0, 100.0, 500.0];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: amounts.map((amount) {
        return InkWell(
          onTap: () => onAmountSelected(amount),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? ColorConfig.backgroundDark
                  : ColorConfig.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? ColorConfig.borderColorDark
                    : ColorConfig.borderColor,
                width: 1,
              ),
            ),
            child: Text(
              '${amount.toInt()}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
