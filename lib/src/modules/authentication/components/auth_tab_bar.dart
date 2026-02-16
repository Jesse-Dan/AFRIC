import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/modules/authentication/components/auth_tab.dart';

class AuthTabBar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const AuthTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? ColorConfig.surfaceDark : ColorConfig.surfaceLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: AuthTab(
              label: 'Login',
              isSelected: selectedTab == 0,
              onTap: () => onTabChanged(0),
            ),
          ),
          Expanded(
            child: AuthTab(
              label: 'Sign Up',
              isSelected: selectedTab == 1,
              onTap: () => onTabChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}
