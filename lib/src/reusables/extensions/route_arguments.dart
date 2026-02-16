extension ArgumentsExtension on Object? {
  T? getArgument<T>(String key) {
    if (this is Map<String, dynamic>) {
      final map = this as Map<String, dynamic>;
      return map[key] as T?;
    }
    return null;
  }
}
