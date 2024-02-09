import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_app/features/authentication/authentication.dart';

import '../../../../core/core.dart';
import '../../../../infra/infra.dart';

class ContactsRepository {
  ContactsRepository(this._firestore, this._storageService);

  final FirebaseFirestore _firestore;
  final SecureStorageService _storageService;

  Future<List<NetWorkUser>> getUsers() async {
    final results = await _firestore
        .collection(
          DBCollection.users,
        )
        .get();

    /// TODO: save users to local storage for caching

    return List.from(
      results.docs.map((e) => NetWorkUser.fromMap(e.data())),
    );
  }

  Stream<NetWorkUser> getUserStream(String id) {
    return _firestore
        .collection(DBCollection.users)
        .doc(id)
        .snapshots()
        .map(NetWorkUser.fromFirestore);
  }

  Future<NetWorkUser> getUser(String id) async {
    final userFromCache = await _storageService.getByKey(StorageKeys.userData);

    if (userFromCache != null) {
      return NetWorkUser.fromMap(jsonDecode(userFromCache));
    }

    final document = await _firestore
        .collection(
          DBCollection.users,
        )
        .doc(id)
        .get();

    final user = NetWorkUser.fromFirestore(document);
    await saveUserToLocalStorage(user);
    return user;
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

  Future<void> saveUserToLocalStorage(NetWorkUser user) {
    return _storageService.save(
      key: StorageKeys.userData,
      value: jsonEncode(user.toMap()),
    );
  }
}
