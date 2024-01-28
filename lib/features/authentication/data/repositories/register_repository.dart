import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/core.dart';
import 'firestore_adapter.dart';

final class RegisterRepository implements FirestoreDbAdapter {
  RegisterRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<void> saveUserToStorage({
    required String uid,
    required String displayName,
    required String email,
  }) {
    return _firestore.collection(DBCollection.users).doc(uid).set(
      {
        uid: uid,
        displayName: displayName,
        email: email,
      },
    );
  }
}
