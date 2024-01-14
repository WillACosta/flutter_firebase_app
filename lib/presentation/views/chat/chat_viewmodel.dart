import 'package:firebase_auth_app/features/chat/domain/domain.dart';

import '../../../core/core.dart';

class ChatViewModel extends ViewModel {
  ChatViewModel(this._createPrivateChatUseCase);
  final CreatePrivateChatUseCase _createPrivateChatUseCase;

  Future<void> createNewChat(String fromUserId, String toUserId) {
    return _createPrivateChatUseCase(CreatePrivateChatParams(
      userId: fromUserId,
      secondPersonId: toUserId,
    ));
  }
}
