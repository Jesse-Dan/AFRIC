import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/client/auth_client.dart';
import 'package:wallet/src/config/route_config.dart';
import 'package:wallet/src/modules/authentication/authentication_view.dart';
import 'package:wallet/src/modules/home/home.dart';
import 'package:wallet/src/modules/splashscreen/splashscreen.dart';
import 'package:wallet/src/providers/base_provider.dart';
import 'package:wallet/src/reusables/models/request/login_payload.dart';
import 'package:wallet/src/reusables/models/request/register_payload.dart';
import 'package:wallet/src/reusables/models/responses/login_response.dart';
import 'package:wallet/src/reusables/models/responses/message_response.dart';
import 'package:wallet/src/reusables/models/responses/register_response.dart';
import 'package:wallet/src/reusables/models/user.dart';
import 'package:wallet/src/reusables/utils/show_loading.dart';
import 'package:wallet/src/reusables/utils/storage_util.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider extends BaseProvider {
  final _client = AuthenticationClient();

  AuthProvider() : super(autoLoad: true, enableDebugLogs: true);

  static const String _firstTimeKey = 'is_first_time';
  static const String _userKey = 'user_data';
  static const String _authTokenKey = 'auth_token';

  User? _user;
  User? get user => _user;

  bool _isFirstTime = true;
  bool get isFirstTime => _isFirstTime;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  @override
  Future<void> loadInitialData() async {
    await Future.wait([_checkFirstTimeUser(), _loadUserFromStorage()]);
  }

  Future<void> _checkFirstTimeUser() async {
    try {
      final value = await StorageUtil.instance.get(_firstTimeKey);
      _isFirstTime = value ?? true;
    } catch (_) {
      _isFirstTime = true;
    }
    notifyListeners();
  }

  Future<void> _loadUserFromStorage() async {
    try {
      final userData = await StorageUtil.instance.get(_userKey);
      final token = await StorageUtil.instance.get(_authTokenKey);

      if (userData != null && token != null) {
        _user = User.fromJson(userData);
        _isAuthenticated = true;
      } else {
        _user = null;
        _isAuthenticated = false;
      }
    } catch (_) {
      _user = null;
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  Future<String> determineNextRoute() async {
    if (_isFirstTime) return SplashScreenView.route;
    if (_isAuthenticated && _user != null) return HomeView.route;
    return AuthView.route;
  }

  Future<void> login(LoginPayload payload) async {
    showLoading();

    await handleApiCall(
      apiCall: () =>
          _client.login(payload: payload, fromJson: LoginResponse.fromJson),
      onSuccess: (response) async {
        _user = response.user;
        _isAuthenticated = true;

        await _saveUserToStorage(response.user, response.authorization?.token);

        // I DID THIS CAUSE OF TIME (I WANTED TO LISTEN TO AUTH STATE BY A LISTENENER)
        Navigator.of(navigatorKey.currentContext!).pushNamed(HomeView.route);

        notifyListeners();
      },
      customErrorMessage: "Failed to login user",
    );

    cancelLoading();
  }

  Future<void> register(RegisterPayload payload) async {
    showLoading();

    await handleApiCall(
      apiCall: () => _client.register(
        payload: payload,
        fromJson: RegisterResponse.fromJson,
      ),
      onSuccess: (_) {
        Navigator.of(navigatorKey.currentContext!).pushNamed(AuthView.route);
      },
      customErrorMessage: "Failed to register user",
    );

    cancelLoading();
  }

  Future<void> _saveUserToStorage(User? user, String? token) async {
    try {
      if (user != null) {
        await StorageUtil.instance.save(_userKey, jsonEncode(user.toJson()));
      }
      if (token != null) {
        await StorageUtil.instance.save(_authTokenKey, token);
      }
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  Future<void> completeFirstTimeExperience() async {
    await StorageUtil.instance.save(_firstTimeKey, false);
    _isFirstTime = false;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      showLoading();
      await handleApiCall(
        apiCall: () => _client.logout(fromJson: MessageResponse.fromJson),
        onSuccess: (_) async {
          await _clearUserData();
        },
        customErrorMessage: "Failed to logout",
      );
    } catch (_) {
      await _clearUserData();
    } finally {
      await forceLogout();
      cancelLoading();
    }
  }

  Future<void> forceLogout() async {
    await _clearUserData();
    await resetAppToFirstTime();
    Navigator.of(
      navigatorKey.currentContext!,
    ).pushNamedAndRemoveUntil(AuthView.route, (route) => false);
  }

  Future<void> _clearUserData() async {
    await StorageUtil.instance.remove(_userKey);
    await StorageUtil.instance.remove(_authTokenKey);

    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> resetAppToFirstTime() async {
    await StorageUtil.instance.clear();

    _user = null;
    _isAuthenticated = false;
    _isFirstTime = true;

    notifyListeners();
  }
}
