import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/core.dart';
import '../../data.dart';

final class CRegisterRepository implements RegisterRepository {
  CRegisterRepository(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<void> registerUserToTheStorage(Map<String, dynamic> userMap) {
    if (!userMap.containsKey('uid')) {
      throw Exception('Invalid uid for new User entry');
    }

    return _firestore
        .collection(DBCollection.users)
        .doc(userMap['uid'])
        .set(userMap);
  }
}
