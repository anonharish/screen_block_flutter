import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusdroid/app.dart';
import 'package:focusdroid/core/storage/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await HiveService.init();

  runApp(
    const ProviderScope(
      child: FocusDroidApp(),
    ),
  );
}
