import 'dart:async';

import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/presentation/params/params.dart';
import 'package:flutter/material.dart';

import '../chat/chat.dart';
import '../contacts/components/components.dart';
import '../contacts/contacts_view.dart';
import 'components/components.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final vm = serviceLocator.get<HomeViewModel>();

  String userName = '';
  late StreamSubscription _subscription;

  @override
  void initState() {
    vm.fetchAllContacts();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _openChannelFor({
    String? channelId,
    ChannelParams? params,
  }) {
    Navigator.pushNamed(
      context,
      '/chat-conversation',
      arguments: ChatConversationArgs(
        currentChannelId: channelId,
        channelParams: params,
      ),
    );
  }

  void _showContactsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ContactsView(
        contacts: vm.contactsState,
        onStartNewChat: (params) => _openChannelFor(params: params),
      ),
    );
  }

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

            if (channels.isEmpty) EmptyChats(userName: userName);

            return ListView.builder(
              itemCount: channels.length,
              itemBuilder: (_, index) {
                final currentChannel = channels[index];
                final channelDescription = currentChannel.createdDate ?? '-';
                final channelName = vm.resolveChannelName(currentChannel);

                return ContactItem(
                  onTap: () => _openChannelFor(channelId: currentChannel.id),
                  title: channelName,
                  description: channelDescription,
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showContactsBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
