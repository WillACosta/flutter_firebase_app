import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../features/authentication/authentication.dart';
import '../../../features/contacts/contacts.dart';

class HomeViewModel extends ViewModel {
  HomeViewModel(
    this._authRepository,
    this._getContactsUseCase,
    this._getChannelsByUserUseCase,
    this._getUserUseCase,
  );

  final AuthenticationRepository _authRepository;
  final GetAllContactsUseCase _getContactsUseCase;
  final GetChannelsByUserUseCase _getChannelsByUserUseCase;
  final GetUserUseCase _getUserUseCase;

  final ValueNotifier<List<UserModel>> contactsState = ValueNotifier([]);

  Stream<UserModel> get currentUser {
    return _getUserUseCase(_authRepository.userId);
  }

  Stream<List<ChannelModel>> get channels {
    return _getChannelsByUserUseCase(_authRepository.userId);
  }

  Future<void> logout() {
    return _authRepository.signOut();
  }

  Future<void> init() async {
    setState(UiState.loading);
    await _getContacts();
  }

  Future<void> _getContacts() async {
    final result = await _getContactsUseCase();

    result.fold(
      (contacts) {
        contactsState.value = contacts;
        setState(UiState.success);
      },
      (failure) => setState(UiState.error),
    );
  }
}
