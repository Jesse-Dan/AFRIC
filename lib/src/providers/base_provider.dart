import 'package:flutter/material.dart';
import 'package:wallet/src/reusables/models/exception/api_exception.dart';
import 'package:wallet/src/reusables/utils/show_text.dart';

enum LoadState { initial, loading, loaded, error, refreshing }

abstract class BaseProvider extends ChangeNotifier {
  BaseProvider({bool autoLoad = true, this.enableDebugLogs = false}) {
    if (autoLoad) {
      load();
    }
  }

  LoadState _loadState = LoadState.initial;
  LoadState get loadState => _loadState;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  final bool enableDebugLogs;

  bool get isInitial => _loadState == LoadState.initial;
  bool get isLoading => _loadState == LoadState.loading;
  bool get isLoaded => _loadState == LoadState.loaded;
  bool get isError => _loadState == LoadState.error;
  bool get isRefreshing => _loadState == LoadState.refreshing;
  bool get hasError => _errorMessage != null;
  bool get canLoad => !isLoading && !isRefreshing;

  void setState(LoadState state) {
    if (_isDisposed) return;
    _loadState = state;
    _safeNotifyListeners();
  }

  void _setError(String? message) {
    if (_isDisposed) return;
    _errorMessage = message;
    setState(LoadState.error);
  }

  void clearError() {
    if (_isDisposed) return;
    _errorMessage = null;
    _safeNotifyListeners();
  }

  Future<void> load() async {
    if (!canLoad) {
      _log('Load skipped, busy ($_loadState)');
      return;
    }

    _log('Loading initial data...');
    setState(LoadState.loading);
    clearError();

    try {
      await loadInitialData();
      setState(LoadState.loaded);
      _log('Initial data loaded');
    } catch (e) {
      _log('Load error: $e');
      _setError('Failed to load data');
    }
  }

  Future<void> refresh() async {
    _log('Refreshing...');
    setState(LoadState.refreshing);
    clearError();

    try {
      await loadInitialData();
      setState(LoadState.loaded);
      _log('Refresh success');
    } catch (e) {
      _log('Refresh error: $e');
      _setError('Failed to refresh data');
    }
  }

  Future<void> loadInitialData();

  Future<T?> handleApiCall<T>({
    required Future<T> Function() apiCall,
    void Function(T response)? onSuccess,
    void Function(String error)? onError,
    bool showErrorToUser = true,
    bool loadingState = true,
    String? customErrorMessage,
  }) async {
    if (_isDisposed) return null;

    try {
      if (loadingState && _loadState != LoadState.refreshing) {
        setState(LoadState.loading);
      }

      final response = await apiCall();
      onSuccess?.call(response);

      if (loadingState) {
        setState(LoadState.loaded);
      }

      clearError();
      return response;
    } on ApiException catch (e) {
      final msg = customErrorMessage ?? e.message;
      _log('API Exception: $msg');

      if (showErrorToUser) showError(msg);
      _setError(msg);
      onError?.call(msg);

      return null;
    } catch (e) {
      final msg = customErrorMessage ?? 'Unexpected error';
      _log('Unexpected: $e');

      if (showErrorToUser) showError(msg);
      _setError(msg);
      onError?.call(msg);

      return null;
    }
  }

  void _safeNotifyListeners() {
    if (!_isDisposed) notifyListeners();
  }

  void _log(String message) {
    if (!enableDebugLogs) return;

    debugPrint('[${runtimeType.toString()}] $message');
  }

  @override
  void dispose() {
    _log('Disposed');
    _isDisposed = true;
    super.dispose();
  }

  void reset() {
    if (_isDisposed) return;
    _log('Reset state');

    _loadState = LoadState.initial;
    _errorMessage = null;
    _safeNotifyListeners();
  }
}
