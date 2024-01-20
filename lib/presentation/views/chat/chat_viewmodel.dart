import 'package:firebase_auth_app/features/authentication/authentication.dart';
import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:flutter/foundation.dart';

import '../../../core/core.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel(
    this._createPrivateChatUseCase,
    this._authRepository,
    this._getMessagesByChannelUseCase,
    this._sendMessageUseCase,
  ) {
    _currentChannelId.value = _authRepository.userId;
  }

  final CreatePrivateChatUseCase _createPrivateChatUseCase;
  final GetMessagesByChannelUseCase _getMessagesByChannelUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final AuthenticationRepository _authRepository;

  final _currentChannelId = ValueNotifier("");
  final _currentUserId = ValueNotifier("");

  Future<void> createNewChat(String toUserId) async {
    setState(UiState.loading);

    final result = await _createPrivateChatUseCase(
      CreatePrivateChatParams(
        currentUserId: _currentUserId.value,
        chattingWithId: toUserId,
      ),
    );

    result.fold(
      (success) {
        _currentChannelId.value = success;
        setState(UiState.success);
      },
      (failure) => setState(UiState.error),
    );
  }

  Stream<List<MessageModel>> get messages {
    return _getMessagesByChannelUseCase(_currentChannelId.value);
  }

  Future<void> sendMessage(String message) async {
    await _sendMessageUseCase(
      SendMessageParams(
        channelId: _currentChannelId.value,
        messageFrom: _currentUserId.value,
        message: message,
      ),
    );
  }
}
