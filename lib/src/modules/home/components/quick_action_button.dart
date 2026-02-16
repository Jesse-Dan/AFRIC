import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/providers/theme_provider.dart';
import 'package:wallet/src/reusables/components/app_container.dart';
import 'package:wallet/src/reusables/extensions/context.dart';
import 'package:wallet/src/reusables/utils/ref_holder.dart';

class QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool addDottedBorder;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.addDottedBorder = false,
  });

  @override
  State<QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton> {
  @override
  Widget build(BuildContext context) {
    final isDark = ProviderHelper.watch(themeProvider) == AppThemeMode.dark;

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(12),
      child: AppContainer(
        color: isDark ? ColorConfig.surfaceDark : ColorConfig.surfaceLight,
        padding: EdgeInsets.symmetric(vertical: 24),
        borderRadius: BorderRadius.circular(12),
        dottedBorder: widget.addDottedBorder,

        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Icon(
                widget.icon,
                size: 32,
                color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
              ),
              SizedBox(height: 8),
              Text(
                widget.label,
                style: context.textTheme.labelLarge?.copyWith(
                  color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
