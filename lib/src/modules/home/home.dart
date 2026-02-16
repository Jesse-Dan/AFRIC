// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/modules/home/components/home_content.dart';
import 'package:wallet/src/providers/auth_provider.dart';
import 'package:wallet/src/providers/theme_provider.dart';
import 'package:wallet/src/reusables/components/simple_app_bar.dart';
import 'package:wallet/src/reusables/utils/ref_holder.dart';

class HomeView extends StatelessWidget {
  static const String route = '/ScreenView';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var c = ProviderHelper.watch(themeProvider);
    var isDark = c == AppThemeMode.dark;

    var authProv = ProviderHelper.watch(authProvider);
    var username = authProv.user?.name ?? 'User';

    return Scaffold(
      appBar: SimpleAppBar(
        title: "Hi $username 👋🏾",
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: ColorConfig.primaryBlack,
            radius: 10,
            child: Icon(
              Icons.person_3,
              size: 22,
              color: ColorConfig.borderColor,
            ),
          ),
        ),
        centerTitle: false,
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            spacing: 10,
            children: [
              CircleAvatar(
                backgroundColor: isDark
                    ? Colors.black
                    : Colors.blueAccent.withOpacity(.1),
                child: IconButton(
                  onPressed: () {
                    ProviderHelper.read(themeProvider.notifier).toggleTheme();
                  },
                  icon: Icon(
                    !isDark ? Icons.light_mode : Icons.dark_mode,
                    color: isDark ? Colors.white : Colors.blueAccent,
                  ),
                ),
              ),

              CircleAvatar(
                backgroundColor: Colors.redAccent.withOpacity(.1),
                child: IconButton(
                  onPressed: () async {
                    await authProv.logout();
                  },
                  icon: Icon(Icons.logout, color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(children: [HomeContentWidget()]),
    );
  }
}
