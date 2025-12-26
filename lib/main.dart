import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/router/router_provider.dart';
import 'core/theme/retain_learn_theme.dart';

/// Main entry point for RetainLearn Flutter App
/// 
/// Architecture: Clean Architecture with Repository Pattern
/// State Management: Riverpod
/// Navigation: GoRouter with auth-aware redirects
/// Backend: Supabase (wrapped in repositories for future migration)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize Supabase
  debugPrint('🚀 Initializing Supabase...');
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );
  
  // Log initial auth state
  final session = Supabase.instance.client.auth.currentSession;
  if (session != null) {
    debugPrint('✅ Supabase initialized with active session');
    debugPrint('   User: ${session.user.email}');
  } else {
    debugPrint('✅ Supabase initialized (no active session)');
  }

  runApp(
    const ProviderScope(
      child: RetainLearnApp(),
    ),
  );
}

/// Root application widget
class RetainLearnApp extends ConsumerWidget {
  const RetainLearnApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the new router provider (includes auth-aware redirects)
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: RetainLearnTheme.lightTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
