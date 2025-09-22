import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:isprime/isprime.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/app_state.dart';

part 'app_state_provider.g.dart';

@riverpod
class AppStateNotifier extends _$AppStateNotifier {
  Timer? _apiTimer;
  SharedPreferences? _prefs;

  @override
  Future<AppState> build() async {
    _prefs = await SharedPreferences.getInstance();
    final state = await _loadPersistedState();
    _startApiCalls();

    ref.onDispose(() {
      _apiTimer?.cancel();
    });

    return state;
  }

  Future<AppState> _loadPersistedState() async {
    final lastPrimeNumber = _prefs!.getInt('lastPrimeNumber');
    final lastPrimeTimeString = _prefs!.getString('lastPrimeTime');
    
    DateTime? lastPrimeTime;
    if (lastPrimeTimeString != null) {
      lastPrimeTime = DateTime.parse(lastPrimeTimeString);
    }

    debugPrint('Loaded state - lastPrime: $lastPrimeNumber, lastTime: $lastPrimeTime');
    return AppState(
      lastPrimeNumber: lastPrimeNumber,
      lastPrimeTime: lastPrimeTime,
    );
  }

  Future<void> _persistState(AppState state) async {
    final formattedTime = DateFormat('HH:mm:ss').format(state.lastPrimeTime!);
    debugPrint('Caching last prime ${state.lastPrimeNumber} at time $formattedTime');
    if (state.lastPrimeNumber != null) {
      await _prefs!.setInt('lastPrimeNumber', state.lastPrimeNumber!);
    }
    if (state.lastPrimeTime != null) {
      await _prefs!.setString('lastPrimeTime', state.lastPrimeTime!.toIso8601String());
    }
  }

  void _startApiCalls() {
    _apiTimer?.cancel();
    _apiTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _fetchRandomNumber();
    });
  }

  Future<void> _fetchRandomNumber() async {
    if (state.value?.isApiCallActive == true) return;
    
    CheckPrime primeChecker = CheckPrime();
    state = AsyncValue.data(state.value!.copyWith(isApiCallActive: true));
    
    try {
      final response = await http.get(
        Uri.parse('http://www.randomnumberapi.com/api/v1.0/random'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final int number = data.first;
        final isPrime = primeChecker.isPrime(number);

        if (isPrime) {
          final now = DateTime.now();
          // Calculating time since last prime before updating state
          String timeSinceLastPrime = '0s'; // Default for very first prime


          final previousTime = state.value!.lastPrimeTime;
          if (previousTime != null) {
            final timeSincePrevious = now.difference(previousTime);
            timeSinceLastPrime = '${timeSincePrevious.inSeconds}s';
          }

          debugPrint('Received a prime number: $number. Time since last: $timeSinceLastPrime.');

          final newState = state.value!.copyWith(
            showPrimeNotification: true,
            lastPrimeNumber: number,
            lastPrimeTime: now,
            timeSinceLastPrime: timeSinceLastPrime, 
            isApiCallActive: false,
          );
          
          await _persistState(newState);
          state = AsyncValue.data(newState);
        } else {
          debugPrint('Received a non-prime number: $number.');
          state = AsyncValue.data(state.value!.copyWith(isApiCallActive: false));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching random number: $e');
      }
      state = AsyncValue.data(state.value!.copyWith(isApiCallActive: false));
    }
  }


  void hideNotification() {
    state = AsyncValue.data(state.value!.copyWith(showPrimeNotification: false));
  }
}
