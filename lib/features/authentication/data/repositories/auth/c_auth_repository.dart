import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/infra/infra.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../models/models.dart';
import 'auth_repository.dart';

class CAuthenticationRepository implements AuthenticationRepository {
  CAuthenticationRepository(
    this._firebaseAuth,
    this._secureStorageService,
  );

  final FirebaseAuth _firebaseAuth;
  final SecureStorageService _secureStorageService;

  @override
  Stream<bool> isAuthenticated() {
    return Rx.combineLatest2(
      _firebaseAuth.authStateChanges(),
      Stream.fromFuture(_secureStorageService.getByKey(StorageKeys.userData)),
      (userFromFirebase, userFromStorage) {
        return userFromFirebase != null && userFromStorage != null;
      },
    );
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
  Future<void> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    final credentials = await _firebaseAuth.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    final user = credentials.user;
    final userData = NetWorkUser.fromFirebaseAuth(user);

    await _secureStorageService.save(
      key: StorageKeys.userData,
      value: jsonEncode(userData),
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
