import 'package:firebase_auth_app/core/core.dart';
import 'package:firebase_auth_app/presentation/presentation.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final vm = serviceLocator.get<SplashViewModel>();

  @override
  void initState() {
    vm.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: LinearProgressIndicator(),
        ),
      ),
    );
  }
}
