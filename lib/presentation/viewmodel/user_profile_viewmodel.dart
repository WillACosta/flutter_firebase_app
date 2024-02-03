import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/features/profile/data/user_profile_repository.dart';
import 'package:flutter/foundation.dart';

import '../../features/authentication/authentication.dart';

class UserViewModel extends ViewModel {
  UserViewModel(this._profileRepository) {
    getUserData();
  }

  final UserProfileRepository _profileRepository;

  final ValueNotifier<UserModel?> _currentUser = ValueNotifier(null);
  UserModel? get currentUser => _currentUser.value;

  final _currentUserId = ValueNotifier("");
  String get currentUserId => _currentUserId.value;

  Future<void> getUserData() async {
    final user = await _profileRepository.getUserFromStorage();

    _currentUser.value = user;
    _currentUserId.value = user?.id ?? '';
  }
}
