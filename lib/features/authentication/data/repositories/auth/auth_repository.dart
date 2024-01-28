import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Stream<User?> authStatus();
  Stream<User?> userChanges();

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
}
