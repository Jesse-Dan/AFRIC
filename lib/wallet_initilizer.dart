// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/modules/splashscreen/splashscreen.dart';
import 'package:wallet/src/providers/auth_provider.dart';
import 'package:wallet/src/reusables/utils/ref_holder.dart';
import 'package:wallet/src/reusables/utils/show_text.dart';
import 'package:wallet/wallet_app.dart';

class AppInitializer extends ConsumerStatefulWidget {
  const AppInitializer({super.key});

  @override
  ConsumerState<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends ConsumerState<AppInitializer> {
  String? _initialRoute;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    try {
      ProviderHelper.init(ref);

      final authProv = ref.read(authProvider);
      await authProv.loadInitialData();

      final route = await authProv.determineNextRoute();

      setState(() {
        _initialRoute = route;
        _isInitialized = true;
      });

      debugPrint('[AppInit] Initial route: $route');
    } catch (e) {
      showText('Failed to load initial app data');
      debugPrint('[AppInit] Error: $e');

      setState(() {
        _initialRoute = SplashScreenView.route;
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen<AuthProvider>(authProvider, (previous, next) {
    //   if (previous == null) return;

    //   if (!previous.isAuthenticated && next.isAuthenticated) {
    //     debugPrint('[Auth] User logged in → redirect to Home');

    //     navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //       HomeView.route,
    //       (route) => false,
    //     );
    //   }

    //   if (previous.isAuthenticated && !next.isAuthenticated) {
    //     debugPrint('[Auth] User logged out → redirect to Login');

    //     navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //       AuthView.route,
    //       (route) => false,
    //     );
    //   }
    // });

    // if (!_isInitialized) {
    //   return const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: Scaffold(body: Center(child: CircularProgressIndicator())),
    //   );
    // }

    return WalletApp(initialRoute: _initialRoute);
  }
}
