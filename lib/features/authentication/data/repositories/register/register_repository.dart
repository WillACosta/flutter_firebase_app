abstract class RegisterRepository {
  Future<void> registerUserToTheStorage({
    required String uid,
    required String displayName,
    required String email,
  });
}
