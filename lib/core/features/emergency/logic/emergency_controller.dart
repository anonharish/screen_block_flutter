import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../data/emergency_log_model.dart';

final emergencyBoxProvider = Provider<Future<Box<EmergencyLogModel>>>((ref) async {
  final box = await Hive.openBox<EmergencyLogModel>('emergencyBox');
  return box;
});

final todayEmergencyProvider = FutureProvider<Duration>((ref) async {
  final box = await ref.read(emergencyBoxProvider);
  final today = DateTime.now();

  final entry = box.values.firstWhere(
    (e) => isSameDate(e.date, today),
    orElse: () => EmergencyLogModel(date: today, usedDuration: Duration.zero),
  );

  return entry.usedDuration;
});

bool isSameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
