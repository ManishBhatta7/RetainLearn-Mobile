import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../presentation/pages/pages.dart';
import '../../presentation/layouts/retain_learn_shell.dart';

/// =============================================================================
/// AUTH NOTIFIER - Bridges Supabase to GoRouter
/// =============================================================================
/// 
/// This is the KEY fix: A singleton ChangeNotifier that listens to Supabase
/// auth state changes and notifies GoRouter to re-run its redirect logic.

class AuthNotifier extends ChangeNotifier {
  late final StreamSubscription<AuthState> _subscription;
  
  AuthNotifier() {
    debugPrint('🔔 AuthNotifier: Initialized');
    
    // Listen to Supabase auth state changes
    _subscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (event) {
        debugPrint('🔔 AuthNotifier: Auth event = ${event.event.name}');
        debugPrint('   Session exists: ${event.session != null}');
        
        // Notify GoRouter to re-run redirect logic
        notifyListeners();
      },
    );
  }
  
  /// Check if user is currently authenticated
  bool get isAuthenticated {
    final session = Supabase.instance.client.auth.currentSession;
    return session != null;
  }
  
  /// Get current user email (for debugging)
  String? get userEmail {
    return Supabase.instance.client.auth.currentUser?.email;
  }
  
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// =============================================================================
/// PROVIDERS
/// =============================================================================

/// Single instance of AuthNotifier - lives for entire app lifecycle
final authNotifierProvider = Provider<AuthNotifier>((ref) {
  final notifier = AuthNotifier();
  ref.onDispose(() => notifier.dispose());
  return notifier;
});

/// Convenience provider for checking auth state
final isAuthenticatedProvider = Provider<bool>((ref) {
  // This will rebuild when authNotifierProvider changes
  final notifier = ref.watch(authNotifierProvider);
  return notifier.isAuthenticated;
});

/// =============================================================================
/// ROUTER PROVIDER
/// =============================================================================

final routerProvider = Provider<GoRouter>((ref) {
  // READ (not watch) the auth notifier - we don't want to recreate the router
  final authNotifier = ref.read(authNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    
    // This is the KEY: GoRouter will call redirect() whenever authNotifier
    // fires notifyListeners()
    refreshListenable: authNotifier,
    
    /// =========================================================================
    /// REDIRECT LOGIC - The "Bulletproof" Version
    /// =========================================================================
    redirect: (context, state) {
      final path = state.matchedLocation;
      
      // Check auth state DIRECTLY from Supabase (most reliable)
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;
      
      // Debug logging
      debugPrint('🧭 Router Redirect:');
      debugPrint('   Path: $path');
      debugPrint('   Is Logged In: $isLoggedIn');
      if (isLoggedIn) {
        debugPrint('   User: ${session.user.email}');
      }
      
      // Define route categories
      final publicRoutes = ['/', '/login', '/signup', '/demo', '/contact', '/splash'];
      final authRoutes = ['/login', '/signup'];
      
      final isPublicRoute = publicRoutes.contains(path);
      final isAuthRoute = authRoutes.contains(path);

      // RULE 1: If logged in AND on auth route (login/signup) → go to dashboard
      if (isLoggedIn && isAuthRoute) {
        debugPrint('   → Redirect to /dashboard (already authenticated)');
        return '/dashboard';
      }

      // RULE 2: If NOT logged in AND on protected route → go to login
      if (!isLoggedIn && !isPublicRoute) {
        debugPrint('   → Redirect to /login (not authenticated)');
        return '/login';
      }

      // RULE 3: No redirect needed
      debugPrint('   → No redirect');
      return null;
    },

    /// =========================================================================
    /// ROUTES
    /// =========================================================================
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Public Routes
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/demo',
        name: 'demo',
        builder: (context, state) => const DemoPage(),
      ),
      GoRoute(
        path: '/contact',
        name: 'contact',
        builder: (context, state) => const ContactPage(),
      ),

      // Protected Routes with Bottom Navigation (RetainLearn Shell)
      ShellRoute(
        builder: (context, state, child) => RetainLearnShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) => const ChatPage(),
          ),
          GoRoute(
            path: '/sources',
            name: 'sources',
            builder: (context, state) => const SourcesPage(),
          ),
          GoRoute(
            path: '/assignments',
            name: 'assignments',
            builder: (context, state) => const AssignmentsPage(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'assignment-detail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return AssignmentDetailPage(assignmentId: id);
                },
              ),
              GoRoute(
                path: 'submit/:id',
                name: 'submit-assignment',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return SubmitAssignmentPage(assignmentId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/classrooms',
            name: 'classrooms',
            builder: (context, state) => const ClassroomsPage(),
          ),
          GoRoute(
            path: '/tools',
            name: 'tools',
            builder: (context, state) => const ToolsPage(),
            routes: [
              GoRoute(
                path: 'ocr',
                name: 'ocr',
                builder: (context, state) => const OcrScannerPage(),
              ),
              GoRoute(
                path: 'voice-reading',
                name: 'voice-reading',
                builder: (context, state) => const VoiceReadingPage(),
              ),
              GoRoute(
                path: 'essay-checker',
                name: 'essay-checker',
                builder: (context, state) => const EssayCheckerPage(),
              ),
              GoRoute(
                path: 'report-upload',
                name: 'report-upload',
                builder: (context, state) => const ReportUploadPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),

      // Other Protected Routes (without bottom nav)
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/learning-style',
        name: 'learning-style',
        builder: (context, state) => const LearningStylePage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/progress',
        name: 'progress',
        builder: (context, state) => const ProgressPage(),
      ),
    ],
    
    errorBuilder: (context, state) => const ErrorPage(),
  );
});

/// =============================================================================
/// LEGACY EXPORTS (for backward compatibility)
/// =============================================================================

/// Auth state enum (kept for backward compatibility with login/signup pages)
/// NOTE: Renamed from AuthState to AppAuthState to avoid conflict with Supabase's AuthState
enum AppAuthState {
  unknown,
  authenticated,
  unauthenticated,
}

/// Legacy provider (redirects to new implementation)
final authStateProvider = StateProvider<AppAuthState>((ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  return isAuth ? AppAuthState.authenticated : AppAuthState.unauthenticated;
});
