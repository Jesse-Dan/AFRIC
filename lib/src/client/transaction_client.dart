import 'package:wallet/src/config/api_client_config.dart';
import 'package:wallet/src/config/utils_config.dart';
import 'package:wallet/src/reusables/models/request/jornal_entry.dart';
import 'package:wallet/src/reusables/utils/storage_util.dart';

class TransactionClient extends ApiClient {
  TransactionClient()
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

  Future<T> debit<T>({
    required JournalEntry journalEntry,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    return post<T>(
      '/account/debit',
      body: journalEntry.toJson(),
      fromJson: fromJson,
    );
  }

  Future<T> credit<T>({
    required JournalEntry journalEntry,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    return post<T>(
      '/account/credit',
      body: journalEntry.toJson(),
      fromJson: fromJson,
    );
  }
}
