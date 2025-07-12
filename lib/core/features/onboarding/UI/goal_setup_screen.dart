import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoalSetupScreen extends StatefulWidget {
  const GoalSetupScreen({super.key});

  @override
  State<GoalSetupScreen> createState() => _GoalSetupScreenState();
}

class _GoalSetupScreenState extends State<GoalSetupScreen> {
  final titleController = TextEditingController();
  int? selectedDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Your Goal")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Your Goal"),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: "Duration (Days)"),
              items: [3, 5, 7, 14, 21]
                  .map((day) => DropdownMenuItem(value: day, child: Text("$day days")))
                  .toList(),
              onChanged: (val) => setState(() => selectedDays = val),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && selectedDays != null) {
                  final goalTitle = titleController.text;
                  final duration = selectedDays!;
                  context.push('/app-selection', extra: {
                    'goalTitle': goalTitle,
                    'duration': duration,
                  });
                }
              },
              child: const Text("Next"),
            )
          ],
        ),
      ),
    );
  }
}
