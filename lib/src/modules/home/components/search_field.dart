import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;

  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: isDark ? ColorConfig.surfaceDark : ColorConfig.surfaceLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'search transactions, e.g. "Groceries" "Netflix"',
          hintStyle: TextStyle(color: ColorConfig.textSecondary, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: ColorConfig.textSecondary),
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
