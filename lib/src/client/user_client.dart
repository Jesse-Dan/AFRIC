import 'package:wallet/src/config/api_client_config.dart';
import 'package:wallet/src/config/utils_config.dart';
import 'package:wallet/src/reusables/utils/storage_util.dart';

class UserCleint extends ApiClient {
  UserCleint()
    : super(
        ApiClientConfig(
          baseUrl: UtilsConfig.baseUrl,
          shouldLog: true,
          onRequest: (req) async {
            final token = await StorageUtil.instance.get("auth_token");

            if (token != null) {
              req.headers['Authorization'] = 'Bearer $token';
            }

            return req;
          },
        ),
      );

  Future<T> userdetails<T>({
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    return get<T>('/user', fromJson: fromJson);
  }
}
