import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final String label;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final IconData? prefixIcon;
  final String? Function(T?)? validator;

  const AppDropdown({
    super.key,
    required this.value,
    required this.label,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          validator: validator,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: ColorConfig.textSecondary),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: ColorConfig.textSecondary, size: 16)
                : null,
            filled: true,
            fillColor: isDark ? ColorConfig.textDark : ColorConfig.surfaceLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: ColorConfig.textSecondary,
          ),
          dropdownColor: isDark
              ? ColorConfig.textDark
              : ColorConfig.surfaceLight,
          style: TextStyle(
            color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
            fontSize: 14,
          ),
          isExpanded: true,
        ),
      ],
    );
  }
}
