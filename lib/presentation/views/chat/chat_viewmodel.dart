import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:firebase_auth_app/presentation/presentation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/core.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel(
    this._createPrivateChatUseCase,
    this._userViewModel,
    this._getMessagesByChannelUseCase,
    this._sendMessageUseCase,
  );

  final UserViewModel _userViewModel;
  final CreatePrivateChatUseCase _createPrivateChatUseCase;
  final GetMessagesByChannelUseCase _getMessagesByChannelUseCase;
  final SendMessageUseCase _sendMessageUseCase;

  String _currentChannelId = '';

  Stream<List<MessageModel>> messagesByChannel(String chattingWithId) {
    return _createPrivateChatUseCase(
      CreatePrivateChatParams(
        currentUserId: _userViewModel.currentUserId,
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
        messageFrom: _userViewModel.currentUserId,
        message: message,
      ),
    );
  }
}
