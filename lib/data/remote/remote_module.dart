



import 'const_helper.dart';

abstract class RemoteModule {
  Future<dynamic> getResponse(
      String pathUrl,
      RequestType requestType, {
        Map<String, dynamic> body = const {},
        Map<String, dynamic> headers = const {},
        bool isQueryParams = false,
      });
}
