import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/reusables/extensions/context.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          'Smarter Banking,\nWith Zero Stress',
          textAlign: TextAlign.center,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Keep your money safe, accessible,\nand always within reach.',
          textAlign: TextAlign.center,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w200,
            color: isDark
                ? ColorConfig.surfaceLight
                : ColorConfig.borderColorDark,
          ),
        ),
      ],
    );
  }
}
