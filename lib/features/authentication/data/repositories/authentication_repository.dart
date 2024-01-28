import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_adapter.dart';

class AuthenticationRepository implements FirebaseAuthAdapter {
  AuthenticationRepository(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  @override
  Stream<User?> authStatus() {
    return _firebaseAuth.authStateChanges();
  }

  @override
  Stream<User?> userChanges() {
    return _firebaseAuth.userChanges();
  }

  @override
  User? get userSnapshot => _firebaseAuth.currentUser;

  @override
  String get userId => userSnapshot?.uid ?? "INVALID";

  @override
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  }
}
