import 'package:wallet/src/config/api_client_config.dart';
import 'package:wallet/src/config/utils_config.dart';
import 'package:wallet/src/reusables/models/request/login_payload.dart';
import 'package:wallet/src/reusables/models/request/register_payload.dart';
import 'package:wallet/src/reusables/utils/storage_util.dart';

class AuthenticationClient extends ApiClient {
  AuthenticationClient()
    : super(
        ApiClientConfig(
          baseUrl: UtilsConfig.baseUrl,
          onRequest: (req) async {
            if (req.url.toString().contains("/user")) {
              final token = await StorageUtil.instance.get("auth_token");

              if (token != null) {
                req.headers['Authorization'] = 'Bearer $token';
              }
            }
            return req;
          },
        ),
      );

  Future<T> login<T>({
    required LoginPayload payload,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    return post<T>('/login', body: payload.toJson(), fromJson: fromJson);
  }

  Future<T> register<T>({
    required RegisterPayload payload,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    return post<T>('/register', body: payload.toJson(), fromJson: fromJson);
  }

  Future<T> logout<T>({
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    return post<T>('/logout', body: {}, fromJson: fromJson);
  }

  Future<T> userdetails<T>({
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    return get<T>('/user', fromJson: fromJson);
  }
}
