import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/lockmode/logic/lock_mode_controller.dart';
import 'package:go_router/go_router.dart';

class LockModeScreen extends ConsumerWidget {
  const LockModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGoal = ref.watch(lockModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Focus Lock Mode")),
      body: asyncGoal.when(
        data: (goal) {
          if (goal == null) {
            return const Center(child: Text("No active goal found."));
          }

          final daysLeft = ref.watch(remainingDaysProvider(goal));

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🎯 Goal: ${goal.title}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  "⏳ Days Left: $daysLeft",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                const Text(
                  "📱 Allowed Apps:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: goal.allowedApps.map((app) {
                    return Chip(label: Text(app));
                  }).toList(),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => context.push('/emergency'),
                  child: const Text("🔓 Emergency Window (1hr)"),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
