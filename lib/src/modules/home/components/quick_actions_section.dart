import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/modules/home/components/quick_action_button.dart';
import 'package:wallet/src/reusables/components/app_buttom_sheet.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: QuickActionButton(
                icon: Icons.arrow_upward_rounded,
                label: 'Send',
                onTap: () {
                  AppBottomSheet.showSendFunds(context);
                },
                addDottedBorder: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: QuickActionButton(
                icon: Icons.arrow_downward_rounded,
                label: 'Receive',
                onTap: () {
                  AppBottomSheet.showReceiveFunds(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
