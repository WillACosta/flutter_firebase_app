import 'package:firebase_auth_app/core/core.dart';
import 'package:flutter/material.dart';

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
      arguments: {userId: userId},
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: vm.uiState,
          builder: (_, state, widget) {
            if (state == UiState.loading) {
              return const CircularProgressIndicator();
            }

            return widget!;
          },
          child: Center(
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
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showContactsBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
