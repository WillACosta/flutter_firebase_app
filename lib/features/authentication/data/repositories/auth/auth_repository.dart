import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Stream<bool> isAuthenticated();
  Stream<User?> userChanges();

  Future<void> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  });

  Future<void> signOut();

  User? get userSnapshot;
}
