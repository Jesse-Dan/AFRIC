// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/modules/authentication/components/terms_checkbox.dart';
import 'package:wallet/src/providers/auth_provider.dart';
import 'package:wallet/src/reusables/components/app_dropdown.dart';
import 'package:wallet/src/reusables/components/app_text_field.dart';
import 'package:wallet/src/reusables/models/request/register_payload.dart';
import 'package:wallet/src/reusables/utils/ref_holder.dart';
import 'package:wallet/src/reusables/utils/show_text.dart';
import 'package:wallet/src/reusables/utils/validator_mixin.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with ValidatorMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currencyController = TextEditingController(text: "NGN");
  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Account',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Start your secure banking experience',
            style: TextStyle(fontSize: 15, color: ColorConfig.textSecondary),
          ),
          SizedBox(height: 32),
          AppTextField(
            controller: _nameController,
            label: 'Full Name',
            hintText: 'Enter your full name',
            prefixIcon: Icons.person_outline,
            validator: (value) => validateNotEmpty(value, "Full Name"),
          ),
          SizedBox(height: 16),
          AppTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: validateEmail,
          ),
          SizedBox(height: 16),

          AppDropdown<String>(
            value: _currencyController.text,
            label: 'Currency',
            hintText: 'Select your currency',
            prefixIcon: Icons.flag,
            items: [
              DropdownMenuItem(value: 'GBP', child: Text('Pounds')),
              DropdownMenuItem(value: 'EUR', child: Text('Euro')),
              DropdownMenuItem(value: 'USD', child: Text('US Dollars')),
              DropdownMenuItem(value: 'NGN', child: Text('Naira')),
            ],
            onChanged: (value) {
              setState(() {
                _currencyController.text = value ?? "NGN";
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a currency';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          AppTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Create a password',
            obscureText: _obscurePassword,
            prefixIcon: Icons.lock_outline,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: ColorConfig.textSecondary,
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: validatePassword,
          ),
          SizedBox(height: 16),
          AppTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hintText: 'Re-enter your password',
            obscureText: _obscureConfirmPassword,
            prefixIcon: Icons.lock_outline,
            validator: (val) =>
                validateConfirmPassword(_passwordController.text, val),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: ColorConfig.textSecondary,
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
          ),
          SizedBox(height: 16),
          TermsCheckbox(
            value: _agreedToTerms,
            onChanged: (value) {
              setState(() {
                _agreedToTerms = value ?? false;
              });
            },
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: ColorConfig.textSecondary.withOpacity(
                  0.3,
                ),
                disabledForegroundColor: ColorConfig.textSecondary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _agreedToTerms
                  ? () async {
                      if (_formKey.currentState!.validate()) {
                        await ProviderHelper.ref
                            .read(authProvider)
                            .register(
                              RegisterPayload(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _nameController.text,
                                currency: _currencyController.text,
                              ),
                            );
                      }
                    }
                  : () {
                      showError("Please agree to the terms and conditions.");
                    },
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
