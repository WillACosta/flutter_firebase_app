import 'package:flutter/material.dart';

import 'presentation/presentation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/signin': (context) => const SignInView(),
        '/home': (context) => const HomeView(),
        '/register': (context) => const RegisterView(),
      },
    );
  }
}
