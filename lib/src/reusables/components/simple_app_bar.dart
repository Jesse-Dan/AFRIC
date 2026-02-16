import 'package:flutter/material.dart';

import '../../config/color_config.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final VoidCallback? onLeadingTap;
  final String? title;
  final String? subtitle;
  final Widget? titleWidget;
  final Widget? trailing;
  final Color? backgroundColor;
  final Widget? leading;
  final bool centerTitle;
  final Widget? bottom;

  const SimpleAppBar({
    super.key,
    this.showLeading = false,
    this.onLeadingTap,
    this.title,
    this.subtitle,
    this.titleWidget,
    this.trailing,
    this.backgroundColor,
    this.leading,
    this.centerTitle = true,
    this.bottom,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);

  @override
  Widget build(BuildContext context) {
    if (centerTitle && (showLeading || leading != null || trailing != null)) {
      return AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.1,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Stack(
            children: [
              Align(alignment: Alignment.center, child: _buildTitle(context)),

              if (showLeading || leading != null)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(child: _buildLeading(context)!),
                ),

              if (trailing != null)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(child: trailing!),
                ),
            ],
          ),
        ),
        bottom: bottom != null
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight + 120),
                child: bottom!,
              )
            : null,
      );
    }

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0.1,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: _buildLeading(context),
      title: _buildTitle(context),
      actions: trailing != null ? <Widget>[trailing!] : null,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight + 120),
              child: bottom!,
            )
          : null,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;
    if (!showLeading) return null;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? ColorConfig.textLight : ColorConfig.primaryBlack;

    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded, color: iconColor, size: 18),
      onPressed: onLeadingTap ?? () => Navigator.of(context).pop(),
    );
  }

  Widget? _buildTitle(BuildContext context) {
    if (titleWidget != null) {
      return titleWidget;
    }

    if (title == null) return null;

    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: centerTitle
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: textTheme.titleMedium?.copyWith(
            color: isDark ? ColorConfig.textLight : ColorConfig.primaryBlack,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: textTheme.bodySmall?.copyWith(
              color: ColorConfig.textSecondary,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
