class ApiException implements Exception {
  final String message;
  int? statusCode;
  final Map<String, List<String>>? errors;

  ApiException({required this.message, this.statusCode, this.errors});

  factory ApiException.fromJson(Map<String, dynamic> json) {
    return ApiException(
      message: json['message'] ?? 'Error occurred while processing response',
      errors: json['errors'] != null
          ? (json['errors'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                (value as List).map((e) => e.toString()).toList(),
              ),
            )
          : null,
    );
  }

  String get errorMessage {
    if (errors == null || errors!.isEmpty) return message;

    final allErrors = errors!.values.expand((list) => list).join(', ');

    return '$message: $allErrors';
  }

  @override
  String toString() => errorMessage;
}
