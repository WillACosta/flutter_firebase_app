import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/features/authentication/authentication.dart';
import 'package:firebase_auth_app/features/contacts/contacts.dart';

class CAuthenticationRepository implements AuthenticationRepository {
  CAuthenticationRepository(this._firebaseAuth, this._contactsRepository);

  final FirebaseAuth _firebaseAuth;
  final ContactsRepository _contactsRepository;

  @override
  Stream<bool> isAuthenticated() {
    // return Rx.combineLatest2(
    //   _firebaseAuth.authStateChanges(),
    //   Stream.fromFuture(_secureStorageService.getByKey(StorageKeys.userData)),
    //   (userFromFirebase, userFromStorage) {
    //     return userFromFirebase != null && userFromStorage != null;
    //   },
    // );

    return _firebaseAuth.authStateChanges().map((user) => user != null);
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

    final signedUserId = credentials.user!.uid;
    final currentUser = await _contactsRepository.getUser(signedUserId);

    await _contactsRepository.saveUserToLocalStorage(currentUser);
  }
}
