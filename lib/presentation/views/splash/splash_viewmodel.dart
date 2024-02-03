import 'package:flutter/widgets.dart';

import '../../../features/authentication/authentication.dart';

class SplashViewModel {
  final AuthenticationRepository _authRepository;
  SplashViewModel(this._authRepository);

  bool isAuthenticated = false;

  init(BuildContext context) async {
    await Future.delayed(const Duration(microseconds: 2000));

    _authRepository.isAuthenticated().listen((authenticated) {
      if (authenticated) {
        Navigator.pushNamed(context, '/home');
      } else {
        Navigator.pushNamed(context, '/signin');
      }
    });
  }
}
