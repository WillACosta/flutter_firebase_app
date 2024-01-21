import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/core.dart';
import '../data.dart';

final class RegisterRepository implements FirestoreDbAdapter {
  RegisterRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<void> saveUserToStorage({
    required String uid,
    required String displayName,
    required String email,
  }) {
    return _firestore.collection(FirestoreKeys.USERS_COLLECTION).doc(uid).set(
      {
        uid: uid,
        displayName: displayName,
        email: email,
      },
    );
  }

  @override
  Future<NetWorkUser> getUser(String id) async {
    final response = await _firestore.collection('users').doc(id).get();
    return NetWorkUser.fromFirestore(response);
  }
}
