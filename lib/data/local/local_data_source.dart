import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataSource {
  final FlutterSecureStorage secureStorage;

  LocalDataSource(this.secureStorage);

  static const accessTokenKey = 'ACCESS_TOKEN';
  static const refreshTokenKey = 'REFRESH_TOKEN';

  Future<void> savePref(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> getPref(String key) async {
    final String? storedRefreshToken = await secureStorage.read(key: key);
    return storedRefreshToken ?? "";
  }

  Future<void> clearPrefs() async {
    await secureStorage.deleteAll();
  }
}