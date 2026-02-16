import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/modules/authentication/authentication_view.dart';
import 'package:wallet/src/modules/home/home.dart';
import 'package:wallet/src/modules/splashscreen/splashscreen.dart';
import 'package:wallet/src/reusables/views/web_view.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return navigatorKey;
});

class RouteConfig {
  static Route<dynamic> buildRoutes(RouteSettings settings, WidgetRef ref) {
    switch (settings.name) {
      case SplashScreenView.route:
        return MaterialPageRoute(builder: (_) => SplashScreenView());
      case HomeView.route:
        return MaterialPageRoute(builder: (_) => HomeView());
      case AuthView.route:
        return MaterialPageRoute(builder: (_) => AuthView());
      case AppWebView.route:
        return MaterialPageRoute(
          builder: (_) => AppWebView(url: settings.arguments as String),
        );
      default:
        return MaterialPageRoute(builder: (_) => SplashScreenView());
    }
  }
}
