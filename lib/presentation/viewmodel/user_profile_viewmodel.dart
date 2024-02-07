import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/features/profile/data/user_profile_repository.dart';

import '../../features/authentication/authentication.dart';

class UserViewModel extends ViewModel {
  final UserProfileRepository _userProfileRepository;

  UserViewModel(this._userProfileRepository) {
    _getAuthenticatedUser();
  }

  late UserModel currentUser;

  Future<void> _getAuthenticatedUser() async {
    currentUser = await _userProfileRepository.getUserFromStorage();
  }

  UserModel get authenticatedUserSnapshot {
    return currentUser;
  }

  String get userId => authenticatedUserSnapshot.id;

  Stream<UserModel> get currentUserStream => Stream.value(currentUser);
}
