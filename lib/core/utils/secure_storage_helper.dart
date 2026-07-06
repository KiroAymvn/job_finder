
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  SecureStorageHelper._();

  static SecureStorageHelper? _instance;

  static Future<SecureStorageHelper>? getInstance() async {
    _instance ??= SecureStorageHelper._();
    return _instance!;
  }

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  final FlutterSecureStorage _storage =
  FlutterSecureStorage(aOptions: _getAndroidOptions());



  // Write data
  Future<void> assignData({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  // Read data
  Future<String?> getData({required String key}) async {
    return await _storage.read(key: key);
  }
// Delete single key
  Future<void> clearCache({required String key}) async {
    await _storage.delete(key: key);
  }

// Delete all keys
  Future<void> clearAllCache() async {
    await _storage.deleteAll();
  }


}
class AppSecureKey{
  static final String token="token";
  static final String userName="userName";
}
