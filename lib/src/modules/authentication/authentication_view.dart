import 'package:flutter/material.dart';
import 'package:wallet/src/modules/authentication/components/auth_tab_bar.dart';
import 'package:wallet/src/modules/authentication/components/login_form.dart';
import 'package:wallet/src/modules/authentication/components/sign_up_form.dart';

class AuthView extends StatefulWidget {
  static const String route = '/AuthView';
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              AuthTabBar(
                selectedTab: _selectedTab,
                onTabChanged: (index) {
                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),
              SizedBox(height: 40),
              _selectedTab == 0 ? LoginForm() : SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
