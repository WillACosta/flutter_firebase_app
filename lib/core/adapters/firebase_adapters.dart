import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthAdapter {
  Stream<User?> authStatus();

  Future<UserCredential> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  });

  Future<UserCredential> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
  });

  Future<void> signOut();

  User? get userSnapshot;
  String get userId;
}

abstract class FirestoreDbAdapter {
  Future<void> saveUserToStorage({
    required String uid,
    required String displayName,
    required String email,
  });
}
