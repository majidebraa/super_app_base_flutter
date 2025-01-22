import '../local/local_data_source.dart';

class HeaderHelper {
  final LocalDataSource localDataSource;

  HeaderHelper({required this.localDataSource});

  Future<Map<String, String>> getAuthorizationHeader() async {
    String? token = await localDataSource.getPref(LocalDataSource.accessTokenKey);
    return {"Authorization": "Bearer $token", "Accept": "application/json"};
  }

  Map<String, String> getGeneralHeaders() {
    return {"Accept": "application/json"};
  }

  Future<Map<String, String>> getUrlEncodedHeaders() async {
    String? token = await localDataSource.getPref(LocalDataSource.accessTokenKey);
    return {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $token",
    };
  }
}
