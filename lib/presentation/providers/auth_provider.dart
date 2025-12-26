import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/user.dart' as domain;
import '../../domain/repositories/auth_repository.dart';
import '../../data/providers/repository_providers.dart';

/// =============================================================================
/// AUTH STATE PROVIDERS
/// =============================================================================
/// 
/// These providers manage authentication state and drive the app's routing.

/// Stream provider that listens to auth state changes
/// This is the primary driver for login/logout redirects
final authStateStreamProvider = StreamProvider<domain.User?>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return authRepo.authStateChanges.map((user) {
    // Debug logging for auth state changes
    if (user != null) {
      debugPrint('🔔 Auth State Changed: LOGGED IN');
      debugPrint('   User: ${user.email}');
      debugPrint('   ID: ${user.id}');
    } else {
      debugPrint('🔔 Auth State Changed: LOGGED OUT');
    }
    return user;
  });
});

/// Provider for checking if user is authenticated
/// Used by GoRouter for redirect logic
final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateStreamProvider);
  return authState.when(
    data: (user) => user != null,
    loading: () => Supabase.instance.client.auth.currentUser != null,
    error: (_, __) => false,
  );
});

/// Provider for the current domain user
final currentDomainUserProvider = Provider<domain.User?>((ref) {
  final authState = ref.watch(authStateStreamProvider);
  return authState.when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// =============================================================================
/// AUTH CONTROLLER (StateNotifier)
/// =============================================================================
/// 
/// Manages auth operations with loading/error states for UI feedback.

/// Auth state for the controller
class AuthControllerState {
  final bool isLoading;
  final String? error;
  final domain.User? user;

  const AuthControllerState({
    this.isLoading = false,
    this.error,
    this.user,
  });

  AuthControllerState copyWith({
    bool? isLoading,
    String? error,
    domain.User? user,
    bool clearError = false,
  }) {
    return AuthControllerState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      user: user ?? this.user,
    );
  }
}

/// Auth controller for managing auth operations
class AuthController extends StateNotifier<AuthControllerState> {
  final AuthRepository _repository;
  
  AuthController(this._repository) : super(const AuthControllerState()) {
    // Initialize with current user if available
    final currentUser = _repository.currentUser;
    if (currentUser != null) {
      state = state.copyWith(user: currentUser);
    }
  }

  /// Sign in with email and password
  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final user = await _repository.signInWithEmail(
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _parseError(e),
      );
      return false;
    }
  }

  /// Sign up with email and password
  Future<bool> signUp({
    required String email,
    required String password,
    String? fullName,
    domain.UserRole role = domain.UserRole.student,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final user = await _repository.signUpWithEmail(
        email: email,
        password: password,
        fullName: fullName,
        role: role,
      );
      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _parseError(e),
      );
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      await _repository.signOut();
      state = const AuthControllerState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _parseError(e),
      );
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordReset(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      await _repository.sendPasswordResetEmail(email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _parseError(e),
      );
      return false;
    }
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Parse error to user-friendly message
  String _parseError(dynamic error) {
    final message = error.toString();
    
    if (message.contains('Invalid login credentials')) {
      return 'Invalid email or password';
    }
    if (message.contains('Email not confirmed')) {
      return 'Please verify your email first';
    }
    if (message.contains('User already registered')) {
      return 'An account with this email already exists';
    }
    if (message.contains('Password should be')) {
      return 'Password must be at least 6 characters';
    }
    if (message.contains('network')) {
      return 'Network error. Please check your connection.';
    }
    
    // Clean up the error message
    return message
        .replaceAll('RepositoryException:', '')
        .replaceAll('Exception:', '')
        .trim();
  }
}

/// Provider for AuthController
final authControllerProvider = 
    StateNotifierProvider<AuthController, AuthControllerState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthController(repository);
});

/// Convenience provider for loading state
final isAuthLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authControllerProvider).isLoading;
});

/// Convenience provider for auth error
final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authControllerProvider).error;
});
