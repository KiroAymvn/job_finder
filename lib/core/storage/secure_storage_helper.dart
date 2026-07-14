import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {

  final FlutterSecureStorage storage;

  SecureStorageHelper(this.storage);

  Future<void> write({
    required String key,
    required String value,
  }) {
    return storage.write(
      key: key,
      value: value,
    );
  }

  Future<String?> read({
    required String key,
  }) {
    return storage.read(key: key);
  }

  Future<void> delete(String key) {
    return storage.delete(key: key);
  }

  Future<void> clear() {
    return storage.deleteAll();
  }


}
