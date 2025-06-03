import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  const SecureStorageHelper._();
  static const _storage = FlutterSecureStorage();
  static Future<void> write(String key, String value) async =>
      await _storage.write(key: key, value: value);
  static Future<String?> read(String key) async =>
      await _storage.read(key: key);
  static Future<void> delete(String key) async =>
      await _storage.delete(key: key);
}
