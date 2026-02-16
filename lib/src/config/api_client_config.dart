import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wallet/src/reusables/models/exception/api_exception.dart';

typedef OnRequest =
    FutureOr<http.BaseRequest> Function(http.BaseRequest request);
typedef OnResponse<T> = T Function(T data);
typedef OnError = void Function(ApiException error);

class ApiClientConfig {
  final String baseUrl;
  final Duration timeout;
  final Map<String, String>? headers;
  final OnRequest? onRequest;
  final OnResponse? onResponse;
  final OnError? onError;
  final bool shouldLog;

  ApiClientConfig({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 15),
    this.headers,
    this.onRequest,
    this.onResponse,
    this.onError,
    this.shouldLog = false,
  });
}

class ApiClient {
  final ApiClientConfig config;
  final http.Client _client;

  ApiClient(this.config) : _client = http.Client();

  Uri _buildUri(String path) {
    return Uri.parse('${config.baseUrl}$path');
  }

  Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    ...?config.headers,
  };

  void _log(String message) {
    if (!config.shouldLog) return;
    _log('[API] $message');
  }

  Future<T> _send<T>(
    http.BaseRequest request, {
    required T Function(Map<String, dynamic> json) fromJson,
    Map<String, String>? headers,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      request.headers.addAll(_defaultHeaders);

      if (headers != null) {
        request.headers.addAll(headers);
      }

      if (config.onRequest != null) {
        request = await config.onRequest!(request);
      }

      _log('');
      _log('═══════════════════════════════════════════════════════');
      _log('🚀 ${request.method} ${request.url}');
      _log('═══════════════════════════════════════════════════════');
      _log('📦 Headers: ${request.headers}');

      if (request is http.Request && request.body.isNotEmpty) {
        try {
          final prettyBody = JsonEncoder.withIndent(
            '  ',
          ).convert(jsonDecode(request.body));
          _log('📤 Request:\n$prettyBody');
        } catch (_) {
          _log('📤 Request: ${request.body}');
        }
      }

      final streamedResponse = await _client
          .send(request)
          .timeout(config.timeout);

      final response = await http.Response.fromStream(streamedResponse);

      stopwatch.stop();
      _log(
        '⏱️  ${stopwatch.elapsedMilliseconds}ms | Status: ${response.statusCode}',
      );

      final Map<String, dynamic> body = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : {};

      if (response.body.isNotEmpty) {
        try {
          final prettyResponse = JsonEncoder.withIndent('  ').convert(body);
          _log('📥 Response:\n$prettyResponse');
        } catch (_) {
          _log('📥 Response: ${response.body}');
        }
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _log('✅ SUCCESS');
        _log('═══════════════════════════════════════════════════════');
        _log('');

        final data = fromJson(body);

        return config.onResponse != null ? config.onResponse!(data) : data;
      }

      // Error
      _log('❌ ERROR');
      _log('═══════════════════════════════════════════════════════');
      _log('');

      final exception = ApiException.fromJson(body)
        ..statusCode = response.statusCode;

      config.onError?.call(exception);
      throw exception;
    } on TimeoutException {
      stopwatch.stop();
      _log('⏱️  ${stopwatch.elapsedMilliseconds}ms (TIMEOUT)');
      _log('❌ Request timeout');
      _log('═══════════════════════════════════════════════════════');
      _log('');

      final exception = ApiException(
        message: 'Request timeout after ${config.timeout.inSeconds}s',
        statusCode: 408,
      );

      config.onError?.call(exception);
      throw exception;
    } catch (e) {
      if (e is ApiException) rethrow;

      stopwatch.stop();
      _log('❌ UNEXPECTED ERROR: $e');
      _log('═══════════════════════════════════════════════════════');
      _log('');

      final exception = ApiException(message: e.toString());
      config.onError?.call(exception);
      throw exception;
    }
  }

  Future<T> get<T>(
    String url, {
    Map<String, String>? headers,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    final request = http.Request('GET', _buildUri(url));
    return _send<T>(request, fromJson: fromJson, headers: headers);
  }

  Future<T> post<T>(
    String url, {
    Object? body,
    Map<String, String>? headers,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    final request = http.Request('POST', _buildUri(url))
      ..body = jsonEncode(body);
    log(request.body, name: "BODY");
    return _send<T>(request, fromJson: fromJson, headers: headers);
  }

  Future<T> put<T>(
    String url, {
    Object? body,
    Map<String, String>? headers,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    final request = http.Request('PUT', _buildUri(url))
      ..body = jsonEncode(body);
    return _send<T>(request, fromJson: fromJson, headers: headers);
  }

  Future<T> patch<T>(
    String url, {
    Object? body,
    Map<String, String>? headers,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    final request = http.Request('PATCH', _buildUri(url))
      ..body = jsonEncode(body);
    return _send<T>(request, fromJson: fromJson, headers: headers);
  }

  Future<T> delete<T>(
    String url, {
    Map<String, String>? headers,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    final request = http.Request('DELETE', _buildUri(url));
    return _send<T>(request, fromJson: fromJson, headers: headers);
  }

  void dispose() {
    _client.close();
  }
}
