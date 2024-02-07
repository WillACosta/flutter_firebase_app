import 'dart:convert';

import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/infra/infra.dart';

import '../../authentication/authentication.dart';

class UserProfileRepository {
  UserProfileRepository(
    this._secureStorageService,
    this._authRepository,
  );

  final SecureStorageService _secureStorageService;
  final AuthenticationRepository _authRepository;

  Future<UserModel> getUserFromStorage() async {
    final userJson = await _secureStorageService.getByKey(
      StorageKeys.userData,
    );

    if (userJson == null) {
      final user = NetWorkUser.fromFirebaseAuth(_authRepository.userSnapshot);
      return UserMapper.toDomain(NetWorkUser.fromMap(user));
    }

    final resultMap = jsonDecode(userJson) as Map<String, dynamic>;
    return UserMapper.toDomain(NetWorkUser.fromMap(resultMap));
  }
}
