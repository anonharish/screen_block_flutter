import 'package:hive/hive.dart';

part 'goal_model.g.dart'; // Will be generated

@HiveType(typeId: 0)
class GoalModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final int durationInDays;

  @HiveField(2)
  final DateTime startDate;

  @HiveField(3)
  final List<String> allowedApps;

  GoalModel({
    required this.title,
    required this.durationInDays,
    required this.startDate,
    required this.allowedApps,
  });
}
