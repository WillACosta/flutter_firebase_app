import 'package:firebase_auth_app/core/di/injection_container.dart';
import 'package:firebase_auth_app/presentation/views/chat/chat.dart';
import 'package:flutter/material.dart';

import '../../params/params.dart';
import '../../utils/utils.dart';
import 'components/components.dart';

class ChatConversationArgs {
  final String? existingChannelId;
  final ChannelUiParams params;

  ChatConversationArgs({
    this.existingChannelId,
    required this.params,
  });
}

class ChatConversionView extends StatefulWidget {
  const ChatConversionView({super.key, required this.args});
  final ChatConversationArgs args;

  @override
  State<ChatConversionView> createState() => _ChatConversionViewState();
}

class _ChatConversionViewState extends State<ChatConversionView> {
  final textController = TextEditingController();
  final vm = serviceLocator.get<ChatViewModel>();

  ChannelUiParams get channelParams => widget.args.params;

  String get channelName => resolveChannelName(
        currentUserId: vm.currentUserId,
        type: channelParams.type,
        users: channelParams.members,
        groupName: channelParams.name,
      );

  String get channelDescription => 'last seen 19:33';

  void onSendMessage() {
    if (textController.text.isEmpty) return;
    vm.sendMessage(textController.text);
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(channelName),
            Text(
              channelDescription,
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 14,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder(
              stream: vm.messagesByChannel(
                widget.args.existingChannelId,
                channelParams,
              ),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!;

                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        final currentMessage = messages[index];
                        return MessageBubble(
                          isCurrentUser:
                              currentMessage.sentBy == vm.currentUserId,
                          message: currentMessage.messageText,
                        );
                      },
                      itemCount: messages.length,
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                suffixIcon: IconButton(
                  onPressed: onSendMessage,
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
