import 'package:firebase_auth_app/features/authentication/authentication.dart';
import 'package:flutter/material.dart';

import '../../../features/chat/chat.dart';
import '../../params/params.dart';
import 'components/components.dart';
import 'group_creation_view.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({
    super.key,
    required this.contacts,
    this.onStartNewChat,
  });

  final List<UserModel> contacts;
  final void Function(ChannelParams)? onStartNewChat;

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  bool isCreatingNewGroup = false;

  String get viewTitle => isCreatingNewGroup ? "Create new group" : "New Chat";
  List<UserModel> get contacts => widget.contacts;

  void _setGroupCreationActive() {
    setState(() {
      isCreatingNewGroup = !isCreatingNewGroup;
    });
  }

  void _handleNewChat(ChannelParams params) {
    if (widget.onStartNewChat == null) return;
    widget.onStartNewChat?.call(params);
  }

  void _handlePrivateChannel(UserModel user) {
    _handleNewChat(
      ChannelParams(type: ChannelType.private, members: [user]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 22),
          ContactsViewTitle(title: viewTitle),
          const SizedBox(height: 22),
          if (!isCreatingNewGroup)
            CreateGroupAction(onCreateGroup: _setGroupCreationActive),
          isCreatingNewGroup
              ? Expanded(
                  child: GroupCreationView(
                    contacts: contacts,
                    onCreateChannel: _handleNewChat,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (_, index) {
                      final user = contacts[index];

                      return ContactItem(
                        title: user.name,
                        description: user.email,
                        onTap: () => _handlePrivateChannel(user),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
