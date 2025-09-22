import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock_provider.g.dart';

@riverpod
class ClockNotifier extends _$ClockNotifier {
  Timer? _timer;

  @override
  DateTime build() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = DateTime.now();
    });

    ref.onDispose(() {
      _timer?.cancel();
    });

    return DateTime.now();
  }
}