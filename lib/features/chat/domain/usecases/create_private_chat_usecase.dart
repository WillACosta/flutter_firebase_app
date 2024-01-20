import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/features/chat/data/data.dart';
import 'package:firebase_auth_app/features/chat/domain/domain.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class CreatePrivateChatUseCase {
  CreatePrivateChatUseCase(this._chatRepository);
  final ChatRepository _chatRepository;

  Future<Result<String, AppFailure>> call(
    CreatePrivateChatParams params,
  ) async {
    try {
      final response = await _chatRepository.createChannel(
        createdByUid: params.currentUserId,
        members: [params.currentUserId, params.chattingWithId],
        type: ChannelType.private.name,
      );

      return successOf(response);
    } catch (e) {
      return failureOf(GenericFailure());
    }
  }
}

class CreatePrivateChatParams {
  final String currentUserId;
  final String chattingWithId;

  CreatePrivateChatParams({
    required this.currentUserId,
    required this.chattingWithId,
  });
}
