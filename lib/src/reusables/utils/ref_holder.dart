import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderHelper {
  static WidgetRef? _ref;
  static bool _isInitialized = false;

  static void init(WidgetRef ref) {
    _ref = ref;
    _isInitialized = true;
  }

  static WidgetRef get ref {
    if (!_isInitialized || _ref == null) {
      throw StateError(
        'ProviderHelper has not been initialized. '
        'Make sure to call ProviderHelper.init(ref) in your app initialization.',
      );
    }
    return _ref!;
  }

  static WidgetRef? get refOrNull => _ref;

  static bool get isInitialized => _isInitialized;

  static void dispose() {
    _ref = null;
    _isInitialized = false;
  }

  static T read<T>(ProviderListenable<T> provider) {
    return ref.read(provider);
  }

  static T watch<T>(ProviderListenable<T> provider) {
    return ref.watch(provider);
  }

  static void listen<T>(
    ProviderListenable<T> provider,
    void Function(T? previous, T next) listener, {
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    ref.listen<T>(provider, listener, onError: onError);
  }

  static void invalidate(ProviderOrFamily provider) {
    ref.invalidate(provider);
  }

  static bool exists(ProviderListenable provider) {
    try {
      ref.read(provider);
      return true;
    } catch (_) {
      return false;
    }
  }
}
