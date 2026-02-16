import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/config/route_config.dart';
import 'package:wallet/src/config/theme_config.dart';
import 'package:wallet/src/modules/splashscreen/splashscreen.dart';
import 'package:wallet/src/providers/theme_provider.dart';

class WalletApp extends ConsumerStatefulWidget {
  final String? initialRoute;

  const WalletApp({super.key, this.initialRoute});

  @override
  ConsumerState<WalletApp> createState() => _WalletAppState();
}

class _WalletAppState extends ConsumerState<WalletApp> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    ThemeMode mode;
    final currentThemeData = ref
        .watch(themeProvider.notifier)
        .getThemeData(View.of(context).platformDispatcher.platformBrightness);

    if (themeMode == AppThemeMode.dark) {
      mode = ThemeMode.dark;
    } else if (themeMode == AppThemeMode.light) {
      mode = ThemeMode.light;
    } else {
      mode = ThemeMode.system;
    }

    return MaterialApp(
      title: 'Wallet App',
      navigatorKey: navigatorKey,
      initialRoute: widget.initialRoute ?? SplashScreenView.route,
      theme: currentThemeData,
      darkTheme: ThemeConfig.darkTheme,
      themeMode: mode,
      onGenerateRoute: (settings) => RouteConfig.buildRoutes(settings, ref),
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (context, child) {
        Widget wrapped = child ?? const SizedBox.shrink();
        wrapped = BotToastInit()(context, wrapped);

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: wrapped,
        );
      },
    );
  }
}
