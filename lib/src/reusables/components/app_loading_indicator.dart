/*
Tide - Common Components
Inline documentation for maintainability.
File: lib/common/components/app_loading_indicator.dart
*/
// ignore_for_file: unused_element, unused_element_parameter

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:loading_progress_indicator/loading_progress_indicator.dart";
import "package:loading_progress_indicator/progress_indicator/line_scale_party_progress_indicator.dart";
import "package:wallet/src/config/color_config.dart";

import "../extensions/context.dart";

class AppLoadingIndicator extends ConsumerWidget {
  final Color? color;
  final Color? textColor;

  final double? size;
  final String? text;

  const AppLoadingIndicator({
    super.key,
    this.color,
    this.textColor,
    this.size,
    this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? ColorConfig.textSecondary,
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: _AppCustomSpinner(),
            ),
          ),
          if (text != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: textColor ?? ColorConfig.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}

class _AppCustomSpinner extends StatelessWidget {
  final Color? loaderColor;
  final double? size;
  final BoxShape shape;

  const _AppCustomSpinner({
    super.key,
    this.loaderColor,
    this.size,
    this.shape = BoxShape.circle,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingProgressIndicator(
      size: size ?? 24,
      indicator: LineScalePartyProgressIndicator(),
      color: ColorConfig.accentGray,
    );
  }
}
