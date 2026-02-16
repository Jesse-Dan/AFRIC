// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';

class SectionHeader extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;

  const SectionHeader({
    super.key,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onToggle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Transactions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
            ),
          ),
          AnimatedRotation(
            turns: isExpanded ? 0 : -0.5,
            duration: Duration(milliseconds: 300),
            child: CircleAvatar(
              backgroundColor: ColorConfig.surfaceDark.withOpacity(.1),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
