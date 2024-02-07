import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_app/features/authentication/authentication.dart';

import '../../../../core/core.dart';

class ContactsRepository {
  ContactsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<List<NetWorkUser>> getUsers() async {
    final results = await _firestore.collection(DBCollection.users).get();

    return List.from(
      results.docs.map((e) => NetWorkUser.fromMap(e.data())),
    );
  }

  Stream<NetWorkUser> getUser(String id) {
    return _firestore
        .collection(DBCollection.users)
        .doc(id)
        .snapshots()
        .map(NetWorkUser.fromFirestore);
  }

  AsyncMapList getUsersByIdList(List<dynamic> ids) async {
    List<Map<String, dynamic>> result = [];

    for (var id in ids) {
      final response = await _firestore
          .collection(
            DBCollection.users,
          )
          .doc(id)
          .get();

      final data = response.data() ?? {};
      result.add(data);
    }

    return result;
  }
}
