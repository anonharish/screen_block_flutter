import 'package:focusdroid/core/features/onboarding/data/goal_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);

     // Register adapters here 👇
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GoalModelAdapter());
    }

    // Open box if needed
    await Hive.openBox<GoalModel>('goalBox');

    // Register adapters and open boxes here
    // Hive.registerAdapter(GoalModelAdapter());
    // await Hive.openBox('goal');
  }
}
