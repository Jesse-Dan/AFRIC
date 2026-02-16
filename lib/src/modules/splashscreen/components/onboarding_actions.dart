import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/modules/authentication/authentication_view.dart';
import 'package:wallet/src/providers/auth_provider.dart';

class OnboardingAction extends ConsumerWidget {
  const OnboardingAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          Navigator.of(context).pushNamed(AuthView.route);
          final authProv = ref.read(authProvider);
          await authProv.completeFirstTimeExperience();
        },
        iconAlignment: IconAlignment.end,
        icon: Icon(Icons.arrow_forward),
        label: Text("Let's go"),
      ),
    );
  }
}
