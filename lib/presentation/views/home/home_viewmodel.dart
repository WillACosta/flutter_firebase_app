import 'package:firebase_auth_app/core/core.dart';
import 'package:flutter/material.dart';

import '../../../features/authentication/authentication.dart';
import '../../../features/contacts/contacts.dart';

class HomeViewModel extends ViewModel {
  HomeViewModel(this._authRepository, this._getContactsUseCase);

  final AuthenticationRepository _authRepository;
  final GetAllContactsUseCase _getContactsUseCase;

  final ValueNotifier<List<User>> contactsState = ValueNotifier([]);

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
