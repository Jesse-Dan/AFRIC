// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 196,
      height: 196,
      decoration: BoxDecoration(
        color: isDark ? ColorConfig.surfaceDark : ColorConfig.surfaceLight,
        borderRadius: BorderRadius.circular(22.4),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 42,
            child: Container(
              width: 112,
              height: 84,
              decoration: BoxDecoration(
                color: isDark
                    ? ColorConfig.primaryBlack.withOpacity(0.8)
                    : ColorConfig.primaryBlack.withOpacity(0.9),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.4),
                  bottom: Radius.circular(11.2),
                ),
              ),
            ),
          ),
          Positioned(
            top: 49,
            right: 56,
            child: Transform.rotate(
              angle: 0.1,
              child: Container(
                width: 70,
                height: 49,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 21,
                        height: 2.8,
                        decoration: BoxDecoration(
                          color: ColorConfig.textSecondary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(1.4),
                        ),
                      ),
                      SizedBox(height: 2.8),
                      Container(
                        width: 28,
                        height: 2.8,
                        decoration: BoxDecoration(
                          color: ColorConfig.textSecondary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(1.4),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 8.4,
                          backgroundColor: ColorConfig.textSecondary
                              .withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
