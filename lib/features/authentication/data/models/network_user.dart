import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

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

  static NetWorkUser fromFirebaseAuth(
    User? user, {
    String userName = 'User',
  }) {
    return NetWorkUser(
      uid: user?.uid ?? const Uuid().v4(),
      name: user?.displayName ?? userName,
      email: user?.email ?? 'No email address available',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  NetWorkUser copyWith({
    String? uid,
    String? name,
    String? email,
  }) {
    return NetWorkUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
