import 'package:cloud_firestore/cloud_firestore.dart';

class NetWorkUser {
  final String uid;
  final String name;
  final String email;

  NetWorkUser({
    required this.uid,
    required this.name,
    required this.email,
  });

  factory NetWorkUser.fromMap(Map<String, dynamic> map) {
    return NetWorkUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  factory NetWorkUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();

    if (data == null) {
      throw const FormatException("There is no data for deserialize");
    }

    return NetWorkUser.fromMap(data);
  }
}
