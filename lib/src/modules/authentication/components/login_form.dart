import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/providers/auth_provider.dart';
import 'package:wallet/src/reusables/components/app_text_field.dart';
import 'package:wallet/src/reusables/models/request/login_payload.dart';
import 'package:wallet/src/reusables/utils/ref_holder.dart';
import 'package:wallet/src/reusables/utils/validator_mixin.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with ValidatorMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            'Welcome back',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDark ? ColorConfig.textLight : ColorConfig.textDark,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Login to continue your banking journey',
            style: TextStyle(fontSize: 15, color: ColorConfig.textSecondary),
          ),
          SizedBox(height: 32),
          AppTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: validateEmail,
          ),
          SizedBox(height: 16),
          AppTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Enter your password',
            obscureText: _obscurePassword,
            prefixIcon: Icons.lock_outline,
            validator: (val) => validateNotEmpty(val, "Password"),
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
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: isDark
                      ? ColorConfig.textLight
                      : ColorConfig.primaryBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text('Login'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ProviderHelper.ref
                      .read(authProvider)
                      .login(
                        LoginPayload(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
