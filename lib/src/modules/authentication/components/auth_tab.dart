import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';

class AuthTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AuthTab({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? ColorConfig.primaryBlack : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? (isDark ? ColorConfig.textLight : ColorConfig.textDark)
                  : ColorConfig.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
