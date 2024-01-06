import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'sign_in_viewmodel.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final vm = serviceLocator.get<SigInViewModel>();
  final formKey = GlobalKey<FormState>();
  late StreamSubscription _subscription;

  void onSubmitForm() {
    formKey.currentState?.save();
    vm.submitForm();
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  void initState() {
    _setListeners();
    super.initState();
  }

  _setListeners() {
    vm.uiState.addListener(() {
      if (vm.uiState.value == UiState.error) {
        context.showSnackBar(
          message: 'Oops! Email or Password invalid!',
          error: true,
        );
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: vm.email,
                  onSaved: vm.setEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'email',
                  ),
                ),
                const SizedBox(height: 23),
                TextFormField(
                  initialValue: vm.password,
                  onSaved: vm.setPassword,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'password',
                  ),
                ),
                const SizedBox(height: 45),
                ListenableBuilder(
                  listenable: vm.uiState,
                  builder: (_, __) {
                    if (vm.uiState.value == UiState.loading) {
                      return const CircularProgressIndicator();
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: onSubmitForm,
                          child: const Text('Sign in'),
                        ),
                        TextButton(
                          onPressed: _navigateToRegister,
                          child: const Text('Register'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
