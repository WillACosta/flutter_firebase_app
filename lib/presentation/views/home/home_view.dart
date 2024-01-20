import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/features/chat/chat.dart';
import 'package:flutter/material.dart';

import '../chat/chat.dart';
import '../contacts/contacts_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final vm = serviceLocator.get<HomeViewModel>();
  final userName = 'Will';

  void _navigateToChatScreen(String userId) {
    Navigator.pushNamed(
      context,
      '/chat-conversation',
      arguments: ChatConversationArgs(chattingWithId: userId),
    );
  }

  void _showContactsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ValueListenableBuilder(
        valueListenable: vm.contactsState,
        builder: (_, contacts, __) => ContactsView(
          users: contacts,
          onSelectedContact: (uid) => _navigateToChatScreen(uid),
        ),
      ),
    );
  }

  @override
  void initState() {
    vm.init();
    super.initState();
  }

  /// TODO:
  /// 1. refactor view code for simplicity
  /// 2. Create a new Widget class for separate logic of:
  ///   EmptyState
  ///   SuccessState = List<Channels>
  ///   LoadingState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('My Chats'),
        actions: [
          IconButton(
            onPressed: vm.logout,
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: StreamBuilder(
          stream: vm.channels,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final channels = snapshot.data!;

              if (channels.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome $userName! :)',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Here, you can find all your chats.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: channels.length,
                  itemBuilder: (_, index) {
                    final currentChannel = channels[index];
                    return ListTile(
                      title: Text(
                        currentChannel.type == ChannelType.private
                            ? currentChannel.members[1]
                            : currentChannel.description ?? 'no-description',
                      ),
                      subtitle: Text(currentChannel.createdDate ?? '-'),
                    );
                  },
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showContactsBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
