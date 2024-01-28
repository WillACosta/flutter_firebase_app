import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_app/infra/infra.dart';

import '../../../../../core/core.dart';
import 'register_repository.dart';

final class CRegisterRepository implements RegisterRepository {
  CRegisterRepository(this._firestore, this._secureStorageService);

  final FirebaseFirestore _firestore;
  final SecureStorageService _secureStorageService;

  @override
  Future<void> registerUserToTheStorage({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    final payload = {
      'uid': uid,
      'name': displayName,
      'email': email,
    };

    await _secureStorageService.save(
      key: StorageKeys.userData,
      value: jsonEncode(payload),
    );

    await _firestore.collection(DBCollection.users).doc(uid).set(payload);
  }
}
