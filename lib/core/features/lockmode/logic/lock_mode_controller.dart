import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../onboarding/data/goal_model.dart';

final lockModeProvider = FutureProvider<GoalModel?>((ref) async {
  final box = await Hive.openBox<GoalModel>('goalBox');
  return box.get('currentGoal');
});

final remainingDaysProvider = Provider.family<int?, GoalModel>((ref, goal) {
  final now = DateTime.now();
  final endDate = goal.startDate.add(Duration(days: goal.durationInDays));
  final diff = endDate.difference(now).inDays;
  return diff >= 0 ? diff : 0;
});
