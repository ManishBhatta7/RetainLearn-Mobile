import 'dart:async';

// Import supabase_flutter but hide the User type to avoid conflict with our domain User
// AuthUser is automatically re-exported and available
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:gotrue/src/types/user.dart' as supabase;

import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'supabase_assignment_repository.dart';

/// Concrete Supabase implementation of AuthRepository
class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _client;
  User? _cachedUser;

  SupabaseAuthRepository(this._client);

  @override
  User? get currentUser {
    final authUser = _client.auth.currentUser;
    if (authUser == null) return null;
    return _cachedUser ?? _mapAuthUserToUser(authUser);
  }

  @override
  bool get isAuthenticated => _client.auth.currentUser != null;

  @override
  Stream<User?> get authStateChanges {
    return _client.auth.onAuthStateChange.map((event) {
      if (event.session?.user != null) {
        _cachedUser = _mapAuthUserToUser(event.session!.user);
        return _cachedUser;
      }
      _cachedUser = null;
      return null;
    });
  }

  @override
  Future<User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw RepositoryException(message: 'Sign in failed: No user returned');
      }

      // Fetch additional profile data
      final profile = await _fetchProfile(response.user!.id);
      _cachedUser = _mergeUserWithProfile(response.user!, profile);
      return _cachedUser!;
    } on AuthException catch (e) {
      throw RepositoryException(message: e.message, originalError: e);
    }
  }

  @override
  Future<User> signUpWithEmail({
    required String email,
    required String password,
    String? fullName,
    UserRole role = UserRole.student,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'role': role.name,
        },
      );

      if (response.user == null) {
        throw RepositoryException(message: 'Sign up failed: No user returned');
      }

      _cachedUser = _mapAuthUserToUser(response.user!);
      return _cachedUser!;
    } on AuthException catch (e) {
      throw RepositoryException(message: e.message, originalError: e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      _cachedUser = null;
    } on AuthException catch (e) {
      throw RepositoryException(message: e.message, originalError: e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw RepositoryException(message: e.message, originalError: e);
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await _client.auth.updateUser(UserAttributes(password: newPassword));
    } on AuthException catch (e) {
      throw RepositoryException(message: e.message, originalError: e);
    }
  }

  @override
  Future<User> updateProfile({
    String? fullName,
    String? avatarUrl,
    UserPreferences? preferences,
  }) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        throw RepositoryException(message: 'Not authenticated');
      }

      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (fullName != null) updates['full_name'] = fullName;
      if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
      if (preferences != null) updates['preferences'] = preferences.toJson();

      final response = await _client
          .from('profiles')
          .update(updates)
          .eq('id', userId)
          .select()
          .single();

      final authUser = _client.auth.currentUser!;
      _cachedUser = _mergeUserWithProfile(authUser, response);
      return _cachedUser!;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<User?> getUserById(String id) async {
    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) return null;
      return User.fromJson(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return _client.auth.currentSession?.accessToken;
  }

  @override
  Future<void> refreshSession() async {
    try {
      await _client.auth.refreshSession();
    } on AuthException catch (e) {
      throw RepositoryException(message: e.message, originalError: e);
    }
  }

  /// Fetches user profile from profiles table
  Future<Map<String, dynamic>?> _fetchProfile(String userId) async {
    try {
      return await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
    } catch (e) {
      return null;
    }
  }

  /// Maps Supabase auth user to domain User
  User _mapAuthUserToUser(supabase.User authUser) {
    final metadata = authUser.userMetadata;
    return User(
      id: authUser.id,
      email: authUser.email ?? '',
      name: metadata?['full_name'] as String?,
      fullName: metadata?['full_name'] as String?,
      role: _parseRole(metadata?['role'] as String?),
      avatarUrl: metadata?['avatar_url'] as String?,
      createdAt: DateTime.tryParse(authUser.createdAt),
    );
  }

  /// Merges auth user with profile data
  User _mergeUserWithProfile(supabase.User authUser, Map<String, dynamic>? profile) {
    if (profile == null) return _mapAuthUserToUser(authUser);

    return User(
      id: authUser.id,
      email: authUser.email ?? '',
      name: profile['full_name'] as String? ?? authUser.userMetadata?['full_name'],
      fullName: profile['full_name'] as String?,
      role: _parseRole(profile['role'] as String?),
      avatarUrl: profile['avatar_url'] as String?,
      school: profile['school'] as String?,
      createdAt: DateTime.tryParse(profile['created_at'] ?? authUser.createdAt),
      updatedAt: DateTime.tryParse(profile['updated_at'] ?? ''),
      preferences: profile['preferences'] != null
          ? UserPreferences.fromJson(profile['preferences'])
          : null,
    );
  }

  UserRole _parseRole(String? role) {
    switch (role) {
      case 'teacher':
        return UserRole.teacher;
      case 'parent':
        return UserRole.parent;
      case 'admin':
        return UserRole.admin;
      case 'school':
        return UserRole.school;
      default:
        return UserRole.student;
    }
  }

  Exception _handleError(dynamic error) {
    if (error is AuthException) {
      return RepositoryException(message: error.message, originalError: error);
    }
    if (error is PostgrestException) {
      return RepositoryException(
        message: error.message,
        code: error.code,
        originalError: error,
      );
    }
    return RepositoryException(
      message: 'An unexpected error occurred',
      originalError: error,
    );
  }
}
