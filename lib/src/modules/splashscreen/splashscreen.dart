import 'package:flutter/material.dart';
import 'package:wallet/src/modules/splashscreen/components/onboarding_actions.dart';
import 'package:wallet/src/modules/splashscreen/components/onboarding_content.dart';
import 'package:wallet/src/modules/splashscreen/components/onboarding_illustration.dart';

class SplashScreenView extends StatelessWidget {
  static const String route = '/SplashScreenView';
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Spacer(flex: 2),
              OnboardingIllustration(),
              SizedBox(height: 60),
              OnboardingContent(),
              Spacer(flex: 3),
              OnboardingAction(),
            ],
          ),
        ),
      ),
    );
  }
}
