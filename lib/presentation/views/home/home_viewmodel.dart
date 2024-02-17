import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:flutter/foundation.dart';

import '../../../features/authentication/authentication.dart';
import '../../../features/contacts/contacts.dart';

class HomeViewModel extends ViewModel {
  final AuthenticationRepository _authRepository;
  final GetChannelsByUserUseCase _getChannelsByUserUseCase;
  final GetAllContactsUseCase _getAllContacts;

  HomeViewModel(
    this._authRepository,
    this._getChannelsByUserUseCase,
    this._getAllContacts,
  );

  final ValueNotifier _contactsState = ValueNotifier<List<UserModel>>([]);

  String get currentUserId => _authRepository.userSnapshot!.uid;
  List<UserModel> get contactsState => _contactsState.value;

  Future<void> fetchAllContacts() async {
    final result = await _getAllContacts();

    result.fold(
      (contacts) => _contactsState.value = contacts,
      (failure) => setState(UiState.error),
    );
  }

  Stream<List<ChannelModel>> get channels {
    return _getChannelsByUserUseCase(currentUserId);
  }

  Future<void> logout() {
    return _authRepository.signOut();
  }
}
