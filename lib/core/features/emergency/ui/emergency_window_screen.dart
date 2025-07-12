import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusdroid/core/features/emergency/data/emergency_log_model.dart';
import 'package:hive/hive.dart';
import '../logic/emergency_controller.dart';

class EmergencyWindowScreen extends ConsumerStatefulWidget {
  const EmergencyWindowScreen({super.key});

  @override
  ConsumerState<EmergencyWindowScreen> createState() => _EmergencyWindowScreenState();
}

class _EmergencyWindowScreenState extends ConsumerState<EmergencyWindowScreen> {
  static const Duration maxEmergency = Duration(hours: 1);
  Timer? _timer;
  Duration remaining = maxEmergency;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        remaining -= const Duration(seconds: 1);
        if (remaining.inSeconds <= 0) {
          endSession();
        }
      });
    });
  }

  void endSession() async {
    _timer?.cancel();

    final box = await Hive.openBox<EmergencyLogModel>('emergencyBox');
    final today = DateTime.now();

    final entry = box.values.firstWhere(
      (e) => isSameDate(e.date, today),
      orElse: () => EmergencyLogModel(date: today, usedDuration: Duration.zero),
    );

    final updated = EmergencyLogModel(
      date: today,
      usedDuration: maxEmergency,
    );

    if (entry.isInBox) {
      await entry.delete();
    }

    await box.add(updated);

    if (mounted) {
      if (!context.mounted) return;
      Navigator.of(context).pop(); // Back to lock screen
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds % 60;

    return Scaffold(
      appBar: AppBar(title: const Text("Emergency Access")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Time left: $minutes:${seconds.toString().padLeft(2, '0')}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: endSession,
              child: const Text("End Early"),
            )
          ],
        ),
      ),
    );
  }
}
