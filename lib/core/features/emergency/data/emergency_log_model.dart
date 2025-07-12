import 'package:hive/hive.dart';

part 'emergency_log_model.g.dart';

@HiveType(typeId: 1)
class EmergencyLogModel extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final Duration usedDuration;

  EmergencyLogModel({
    required this.date,
    required this.usedDuration,
  });
}
