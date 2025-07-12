import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusdroid/core/features/emergency/ui/emergency_window_screen.dart';
import 'package:focusdroid/core/features/lockmode/ui/lock_mode_screen.dart';
import 'package:focusdroid/core/features/onboarding/UI/app_selection_screen.dart';
import 'package:focusdroid/core/features/onboarding/UI/goal_setup_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const GoalSetupScreen(),
      ),
      GoRoute(
        path: '/app-selection',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return AppSelectionScreen(
            goalTitle: extra['goalTitle'],
            duration: extra['duration'],
          );
        },
      ),

      GoRoute(
        path: '/lock',
        builder: (context, state) => const LockModeScreen(),
      ),
      GoRoute(
  path: '/emergency',
  builder: (context, state) => const EmergencyWindowScreen(),
),
    ],
  );
});
