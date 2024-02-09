import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/core.dart';
import '../../../features/authentication/authentication.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel(
    this._createPrivateChatUseCase,
    this._getMessagesByChannelUseCase,
    this._sendMessageUseCase,
    this._authRepository,
  );

  final CreatePrivateChatUseCase _createPrivateChatUseCase;
  final GetMessagesByChannelUseCase _getMessagesByChannelUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final AuthenticationRepository _authRepository;

  String _currentChannelId = '';
  String get currentUserId => _authRepository.userSnapshot!.uid;

  Stream<List<MessageModel>> messagesByChannel(String chattingWithId) {
    return _createPrivateChatUseCase(
      CreatePrivateChatParams(
        currentUserId: currentUserId,
        chattingWithId: chattingWithId,
      ),
    ).switchMap(
      (channelId) {
        _currentChannelId = channelId;
        return _getMessagesByChannelUseCase(channelId);
      },
    );
  }

  Future<void> sendMessage(String message) async {
    await _sendMessageUseCase(
      SendMessageParams(
        channelId: _currentChannelId,
        messageFrom: currentUserId,
        message: message,
      ),
    );
  }
}
