import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_app/core/adapters/adapters.dart';
import 'package:firebase_auth_app/features/authentication/authentication.dart';

class ContactsRepository {
  ContactsRepository(this._firestore, this._authRepository);

  final AuthenticationRepository _authRepository;
  final FirebaseFirestore _firestore;

  Future<List<NetWorkUser>> getUsers() async {
    final results = await _firestore
        .collection(FirestoreKeys.USERS_COLLECTION)
        .where('uid', isNotEqualTo: _authRepository.userId)
        .get();

    return List.from(
      results.docs.map((e) => NetWorkUser.fromMap(e.data())),
    );
  }
}
