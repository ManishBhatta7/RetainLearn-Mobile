import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/assignment.dart';
import '../../domain/repositories/assignment_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../repositories/supabase_assignment_repository.dart';
import '../repositories/supabase_auth_repository.dart';
import '../repositories/gemini_repository.dart';

/// =============================================================================
/// SUPABASE CLIENT PROVIDER
/// =============================================================================

/// Provides the Supabase client instance
final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// =============================================================================
/// REPOSITORY PROVIDERS
/// =============================================================================
/// 
/// These providers expose ABSTRACT repository interfaces to the UI layer.
/// The UI never knows it's talking to Supabase - it only sees the interface.
/// 
/// ## Backend Migration Guide:
/// 
/// To switch from Supabase to a custom Node.js backend:
/// 
/// 1. Create new repository implementations:
///    - `HttpAssignmentRepository implements AssignmentRepository`
///    - `HttpAuthRepository implements AuthRepository`
/// 
/// 2. Update these providers to return the new implementations:
///    ```dart
///    final assignmentRepositoryProvider = Provider<AssignmentRepository>(
///      (ref) => HttpAssignmentRepository(ref.read(httpClientProvider)),
///    );
///    ```
/// 
/// 3. The UI layer remains UNCHANGED because it only depends on
///    the abstract interfaces.
/// =============================================================================

/// Provides the AssignmentRepository interface
/// 
/// Currently returns SupabaseAssignmentRepository, but can be swapped
/// for HttpAssignmentRepository without any UI changes.
final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  final client = ref.read(supabaseProvider);
  return SupabaseAssignmentRepository(client);
});

/// Provides the AuthRepository interface
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.read(supabaseProvider);
  return SupabaseAuthRepository(client);
});

/// Provides the GeminiRepository
final geminiRepositoryProvider = Provider((ref) {
  final client = ref.read(supabaseProvider);
  return GeminiRepository(client);
});

/// =============================================================================
/// STATE PROVIDERS
/// =============================================================================

/// Provides the list of assignments
final assignmentsProvider = FutureProvider<List<Assignment>>((ref) async {
  final repository = ref.read(assignmentRepositoryProvider);
  return repository.getAssignments();
});

/// Provides a single assignment by ID
final assignmentByIdProvider = FutureProvider.family<Assignment?, String>(
  (ref, id) async {
    final repository = ref.read(assignmentRepositoryProvider);
    return repository.getAssignmentById(id);
  },
);

/// Provides assignments for a specific classroom
final assignmentsByClassroomProvider = FutureProvider.family<List<Assignment>, String>(
  (ref, classroomId) async {
    final repository = ref.read(assignmentRepositoryProvider);
    return repository.getAssignmentsByClassroom(classroomId);
  },
);

/// Real-time stream of assignments
final assignmentsStreamProvider = StreamProvider<List<Assignment>>((ref) {
  final repository = ref.read(assignmentRepositoryProvider);
  return repository.watchAssignments();
});

/// =============================================================================
/// AUTH STATE PROVIDERS
/// =============================================================================

/// Provides the current authenticated user
final currentUserProvider = Provider((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.currentUser;
});

/// Stream of auth state changes
final authStateProvider = StreamProvider((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.authStateChanges;
});

/// Whether user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.isAuthenticated;
});

/// =============================================================================
/// NOTIFIER FOR ASSIGNMENT OPERATIONS (CRUD)
/// =============================================================================

/// StateNotifier for managing assignment operations
class AssignmentsNotifier extends StateNotifier<AsyncValue<List<Assignment>>> {
  final AssignmentRepository _repository;

  AssignmentsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadAssignments();
  }

  Future<void> loadAssignments() async {
    state = const AsyncValue.loading();
    try {
      final assignments = await _repository.getAssignments();
      state = AsyncValue.data(assignments);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createAssignment(Assignment assignment) async {
    try {
      final newAssignment = await _repository.createAssignment(assignment);
      state.whenData((assignments) {
        state = AsyncValue.data([newAssignment, ...assignments]);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateAssignment(Assignment assignment) async {
    try {
      final updated = await _repository.updateAssignment(assignment);
      state.whenData((assignments) {
        final index = assignments.indexWhere((a) => a.id == assignment.id);
        if (index != -1) {
          final newList = [...assignments];
          newList[index] = updated;
          state = AsyncValue.data(newList);
        }
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteAssignment(String id) async {
    try {
      await _repository.deleteAssignment(id);
      state.whenData((assignments) {
        state = AsyncValue.data(
          assignments.where((a) => a.id != id).toList(),
        );
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await loadAssignments();
  }
}

/// Provider for AssignmentsNotifier
final assignmentsNotifierProvider =
    StateNotifierProvider<AssignmentsNotifier, AsyncValue<List<Assignment>>>(
  (ref) {
    final repository = ref.read(assignmentRepositoryProvider);
    return AssignmentsNotifier(repository);
  },
);
