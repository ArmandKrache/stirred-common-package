import 'package:stirred_common_domain/src/data/http_error_client.dart';

/// A data source allowing to send methods through a [HttpRestClient], mostly
/// related to devices.
///
/// This data source should only be used in repositories.
class DeviceApi {
  const DeviceApi({
    required this.httpRestClient,
  });

  /// The [HttpRestClient] used to send the HTTP requests.
  final HttpRestClient httpRestClient;

  final String loginEndpoint = '/auth/token/login/';

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    final result = await httpRestClient.post(
      loginEndpoint,
      body: {
        'email': email,
        'password': password,
      },
    );

    return result;
  }

}
