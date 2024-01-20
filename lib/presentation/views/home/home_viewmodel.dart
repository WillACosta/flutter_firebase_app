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
  );

  final AuthenticationRepository _authRepository;
  final GetAllContactsUseCase _getContactsUseCase;
  final GetChannelsByUserUseCase _getChannelsByUserUseCase;

  final ValueNotifier<List<User>> contactsState = ValueNotifier([]);

  Stream<List<ChannelModel>> get channels {
    return _getChannelsByUserUseCase(_authRepository.userId);
  }

  logout() {
    _authRepository.signOut();
  }

  void init() {
    setState(UiState.loading);
    Future.wait([_getContacts()]);
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
