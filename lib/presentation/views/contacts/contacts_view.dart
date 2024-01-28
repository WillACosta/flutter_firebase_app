import 'package:firebase_auth_app/features/authentication/authentication.dart';
import 'package:flutter/material.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({
    super.key,
    required this.users,
    this.onSelectedContact,
  });

  final List<UserModel> users;
  final void Function(String)? onSelectedContact;

  void _handleSelectedContact(String uid) {
    if (onSelectedContact == null) return;
    onSelectedContact?.call(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 22),
          const Text(
            'My Contacts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 22),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];

                return ListTile(
                  onTap: () => _handleSelectedContact(user.id),
                  title: Text(user.name),
                  subtitle: Text(
                    user.email,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
