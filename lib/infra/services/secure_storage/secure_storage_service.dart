import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class SecureStorageService {
  Future<void> save({required String key, required String value});
  Future<String?> getByKey(String key);
  Future<void> deleteAt(String key);
  Future<void> clear();
}

class CSecureStorageService implements SecureStorageService {
  CSecureStorageService() {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  late FlutterSecureStorage _storage;

  @override
  Future<void> clear() {
    return _storage.deleteAll();
  }

  @override
  Future<void> deleteAt(String key) {
    return _storage.delete(key: key);
  }

  @override
  Future<String?> getByKey(String key) {
    return _storage.read(key: key);
  }

  @override
  Future<void> save({required String key, required String value}) {
    return _storage.write(key: key, value: value);
  }
}
