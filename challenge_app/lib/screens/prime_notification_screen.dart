import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_state_provider.dart';

class PrimeNotificationScreen extends ConsumerWidget {
  const PrimeNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStateNotifier = ref.read(appStateProvider.notifier);
    final appState = ref.watch(appStateProvider).value;
    
    if (appState == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Green indicator bar
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 40),
            
            // Congrats text
            const Text(
              'Congrats!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            
            // Prime number message
            Text(
              'You obtained a prime number, it was: ${appState.lastPrimeNumber}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            // Time since last prime
            Text(
              'Time since last prime number ${appState.timeSinceLastPrime ?? '0s'}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            
            // Close button
            SizedBox(
              width: 100,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  appStateNotifier.hideNotification();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}