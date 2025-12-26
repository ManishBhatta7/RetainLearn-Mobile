import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'router_provider.dart';
import '../../presentation/pages/pages.dart';
import '../../presentation/layouts/retain_learn_shell.dart';
import '../../presentation/screens/board_exam_dashboard_screen.dart';

/// GoRouter provider for navigation
final appRouterProvider = Provider<GoRouter>((ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = isAuth;
      final isLoggingIn = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';
      final isPublicRoute = state.matchedLocation == '/' ||
          state.matchedLocation == '/demo' ||
          state.matchedLocation == '/contact' ||
          state.matchedLocation == '/board-exam';  // Allow demo access

      // If not logged in and trying to access protected route
      if (!isLoggedIn && !isLoggingIn && !isPublicRoute) {
        return '/login';
      }

      // If logged in and trying to access login/signup
      if (isLoggedIn && isLoggingIn) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
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
      
      // Board Exam Dashboard (Public for demo)
      GoRoute(
        path: '/board-exam',
        name: 'board-exam',
        builder: (context, state) => const BoardExamDashboardScreen(),
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
