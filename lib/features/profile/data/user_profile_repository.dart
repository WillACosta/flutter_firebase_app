import 'dart:convert';

import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/infra/infra.dart';

import '../../authentication/authentication.dart';

class UserProfileRepository {
  UserProfileRepository(this._secureStorageService);
  final SecureStorageService _secureStorageService;

  Future<String> idSnapshot() async {
    final user = await getUserFromStorage();
    return user.id;
  }

  Future<UserModel> getUserFromStorage() async {
    final resultString = await _secureStorageService.getByKey(
          StorageKeys.userData,
        ) ??
        "{}";

    final resultMap = jsonDecode(resultString) as Map<String, dynamic>;
    return UserMapper.toDomain(NetWorkUser.fromMap(resultMap));
  }
}
