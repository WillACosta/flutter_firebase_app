// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_app/core/adapters/firebase_adapters.dart';

final class RegisterRepository implements FirestoreDbAdapter {
  RegisterRepository(this._firestore);

  final FirebaseFirestore _firestore;
  final _USERS_COLLECTION_KEY = 'users';

  @override
  Future<void> saveUserToStorage({
    required String uid,
    required String displayName,
    required String email,
  }) {
    return _firestore.collection(_USERS_COLLECTION_KEY).doc(uid).set(
      {
        uid: uid,
        displayName: displayName,
        email: email,
      },
    );
  }
}
