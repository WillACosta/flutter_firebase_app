import 'package:flutter/material.dart';

import 'presentation/presentation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return switch (settings.name) {
          '/' => MaterialPageRoute(builder: (_) => const SplashView()),
          '/signin' => MaterialPageRoute(builder: (_) => const SignInView()),
          '/home' => MaterialPageRoute(builder: (_) => const HomeView()),
          '/register' =>
            MaterialPageRoute(builder: (_) => const RegisterView()),
          '/chat-conversation' => MaterialPageRoute(
              builder: (_) => const ChatConversionView(
                userId: "",
              ),
            ),
          _ => MaterialPageRoute(builder: (_) => Container()),
        };
      },
    );
  }
}
