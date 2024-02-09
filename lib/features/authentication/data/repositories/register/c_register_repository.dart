import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/core/constants/app_keys.dart';

import '../../data.dart';

final class CRegisterRepository implements RegisterRepository {
  CRegisterRepository(
    this._firestore,
    this._firebaseAuth,
  );

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<NetWorkUser> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return NetWorkUser.fromFirebaseAuth(
      credentials.user,
      userName: name,
    );
  }

  @override
  Future<void> saveUserToStorage(NetWorkUser user) {
    return _firestore.collection(DBCollection.users).doc().set(
          user.toMap(),
        );
  }
}
