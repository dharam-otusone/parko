import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const _storage = FlutterSecureStorage();

  Future<void> saveToken(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> getAccessToken() => _storage.read(key: 'accessToken');
  Future<String?> getRefreshToken() => _storage.read(key: 'refreshToken');

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
