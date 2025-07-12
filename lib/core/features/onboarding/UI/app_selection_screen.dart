import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../data/goal_model.dart';

class AppSelectionScreen extends StatefulWidget {
  final String goalTitle;
  final int duration;

  const AppSelectionScreen({
    super.key,
    required this.goalTitle,
    required this.duration,
  });

  @override
  State<AppSelectionScreen> createState() => _AppSelectionScreenState();
}

class _AppSelectionScreenState extends State<AppSelectionScreen> {
  final mockApps = ["Phone", "Messages", "WhatsApp", "Camera", "Banking", "Todo"];
  final selectedApps = <String>{};

  void toggleApp(String appName) {
    setState(() {
      if (selectedApps.contains(appName)) {
        selectedApps.remove(appName);
      } else if (selectedApps.length < 6) {
        selectedApps.add(appName);
      }
    });
  }

  void saveGoal() async {
  
    final goal = GoalModel(
      title: widget.goalTitle,
      durationInDays: widget.duration,
      startDate: DateTime.now(),
      allowedApps: selectedApps.toList(),
    );
  
    final box = await Hive.openBox<GoalModel>('goalBox');
    await box.put('currentGoal', goal);
    
    if (mounted) {
      print("Goal saved: $goal");
      context.go('/lock'); // Navigate to lock screen (to be implemented)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Allowed Apps")),
      body: ListView(
        children: mockApps
            .map((app) => CheckboxListTile(
                  title: Text(app),
                  value: selectedApps.contains(app),
                  onChanged: (_) => toggleApp(app),
                ))
            .toList(),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: selectedApps.isNotEmpty ? saveGoal : null,
        child: const Text("Start Lock Mode"),
      ),
    );
  }
}
