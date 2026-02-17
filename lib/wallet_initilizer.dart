// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/modules/splashscreen/splashscreen.dart';
import 'package:wallet/src/providers/auth_provider.dart';
import 'package:wallet/src/reusables/components/app_loading_indicator.dart';
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

      if (authProv.isAuthenticated) {
        Future.microtask(() async {
          try {
            await authProv.getUserDetails();
          } catch (e) {
            debugPrint('[AppInit] Failed to get user details: $e');
          }
        });
      }

      final route = await authProv.determineNextRoute();

      if (mounted) {
        setState(() {
          _initialRoute = route;
          _isInitialized = true;
        });
      }

      debugPrint('[AppInit] Initial route: $route');
      debugPrint('[AppInit] Is authenticated: ${authProv.isAuthenticated}');
      debugPrint('[AppInit] Is first time: ${authProv.isFirstTime}');
    } catch (e) {
      showText('Failed to load initial app data');
      debugPrint('[AppInit] Error: $e');

      if (mounted) {
        setState(() {
          _initialRoute = SplashScreenView.route;
          _isInitialized = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: AppLoadingIndicator())),
      );
    }

    return WalletApp(initialRoute: _initialRoute);
  }
}
