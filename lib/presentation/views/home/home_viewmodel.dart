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
  final ValueNotifier<List<UserModel>> contactsState = ValueNotifier([]);

  /// TODO: criar um novo Stream para obter o ID do usuário via
  /// firestore, criar um novo método no Rep. Contacts
  String get currentUserId => _authRepository.userSnapshot!.uid;

  Stream<List<ChannelModel>> get channels {
    return _getChannelsByUserUseCase(currentUserId);
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

  (String, List<UserModel>) resolveChannelNameAndUserList(
    ChannelModel channel,
  ) {
    final type = channel.type;
    final members = channel.members;
    final channelName = channel.description;

    if (type == ChannelType.private) {
      final foundChattingWith = members
          .where(
            (user) => user.id != currentUserId,
          )
          .toList();

      return (foundChattingWith.first.name, foundChattingWith);
    }

    return (channelName!, members);
  }
}
