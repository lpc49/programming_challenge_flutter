import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/clock_screen.dart';
import 'screens/prime_notification_screen.dart';
import 'providers/app_state_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prime Clock',
      theme: ThemeData.dark(useMaterial3: true),
      home: const AppWrapper(),
    );
  }
}

class AppWrapper extends ConsumerWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    
    return appState.when(
      data: (state) {
        if (state.showPrimeNotification) {
          return const PrimeNotificationScreen();
        }
        return const ClockScreen();
      },
      loading: () => const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => const ClockScreen(),
    );
  }
}
