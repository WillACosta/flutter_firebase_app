// search for available users in firestore DB

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_app/core/adapters/adapters.dart';

import '../../authentication/domain/domain.dart';

class ContactsRepository {
  ContactsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Future<List<UserModel>> getUsers() async {
    final results = await _firestore
        .collection(
          FirestoreKeys.USERS_COLLECTION,
        )
        .get();

    return List.from(
      results.docs.map((e) => UserModel.fromMap(e.data())),
    );
  }
}
