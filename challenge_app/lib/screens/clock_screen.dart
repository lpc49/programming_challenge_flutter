import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/clock_provider.dart';

class ClockScreen extends ConsumerWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(clockProvider);
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('HH:mm').format(currentTime),
              style: const TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: -4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _getDateString(currentTime),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDateString(DateTime date) {
    final weekday = DateFormat('E').format(date);
    final day = date.day;
    final month = DateFormat('MMM').format(date);
    final weekNumber = _getWeekNumber(date);
    
    return '$weekday. $day. $month. KW $weekNumber';
  }

  int _getWeekNumber(DateTime date) { 
    // seems like this doesn't exist natively in intl DateFormat 
    final startOfYear = DateTime(date.year, 1, 1);
    final firstMonday = startOfYear.add(Duration(days: (8 - startOfYear.weekday) % 7));
    
    if (date.isBefore(firstMonday)) {
      return _getWeekNumber(DateTime(date.year - 1, 12, 31));
    }
    
    return ((date.difference(firstMonday).inDays) / 7).floor() + 1;
  }
}
