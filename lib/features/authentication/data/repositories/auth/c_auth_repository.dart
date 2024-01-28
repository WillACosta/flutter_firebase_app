import 'package:firebase_auth/firebase_auth.dart';

import 'auth_repository.dart';

class CAuthenticationRepository implements AuthenticationRepository {
  CAuthenticationRepository(this._firebaseAuth);
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
