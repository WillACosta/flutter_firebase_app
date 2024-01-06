import '../../../features/authentication/authentication.dart';

class HomeViewModel {
  final AuthenticationRepository _authRepository;
  HomeViewModel(this._authRepository);

  logout() {
    _authRepository.signOut();
  }
}
