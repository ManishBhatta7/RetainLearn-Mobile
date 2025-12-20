import '../models/user.dart';

/// Abstract Authentication Repository
/// 
/// Defines the contract for all authentication operations.
/// Currently implemented by SupabaseAuthRepository, but can be
/// swapped for any other auth provider.
abstract class AuthRepository {
  /// Current authenticated user (null if not logged in)
  User? get currentUser;

  /// Stream of auth state changes
  Stream<User?> get authStateChanges;

  /// Sign in with email and password
  Future<User> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<User> signUpWithEmail({
    required String email,
    required String password,
    String? fullName,
    UserRole role = UserRole.student,
  });

  /// Sign out the current user
  Future<void> signOut();

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  /// Update user password
  Future<void> updatePassword(String newPassword);

  /// Update user profile
  Future<User> updateProfile({
    String? fullName,
    String? avatarUrl,
    UserPreferences? preferences,
  });

  /// Get user profile by ID
  Future<User?> getUserById(String id);

  /// Check if user is authenticated
  bool get isAuthenticated;

  /// Get the current session token (for API calls)
  Future<String?> getAccessToken();

  /// Refresh the session
  Future<void> refreshSession();
}
