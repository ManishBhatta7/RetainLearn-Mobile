import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/assignment.dart';
import '../../domain/repositories/assignment_repository.dart';

/// Concrete Supabase implementation of AssignmentRepository
/// 
/// This class handles all Supabase-specific logic for assignment operations.
/// The UI layer never imports this class directly - it only uses the
/// abstract AssignmentRepository interface.
/// 
/// ## Key Design Decisions:
/// 
/// 1. All Supabase client calls are encapsulated here
/// 2. Errors are caught and transformed into domain-specific exceptions
/// 3. JSON mapping happens only in this layer
/// 4. The abstract interface ensures this can be swapped without UI changes
class SupabaseAssignmentRepository implements AssignmentRepository {
  final SupabaseClient _client;

  SupabaseAssignmentRepository(this._client);

  /// Helper to get current user ID
  String? get _currentUserId => _client.auth.currentUser?.id;

  @override
  Future<List<Assignment>> getAssignments() async {
    try {
      final response = await _client
          .from('assignments')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Assignment.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Assignment?> getAssignmentById(String id) async {
    try {
      final response = await _client
          .from('assignments')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) return null;
      return Assignment.fromJson(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<Assignment>> getAssignmentsByClassroom(String classroomId) async {
    try {
      final response = await _client
          .from('assignments')
          .select()
          .eq('classroom_id', classroomId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Assignment.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Assignment> createAssignment(Assignment assignment) async {
    try {
      final data = assignment.toJson();
      data.remove('id'); // Let Supabase generate the ID
      data['teacher_id'] = _currentUserId;

      final response = await _client
          .from('assignments')
          .insert(data)
          .select()
          .single();

      return Assignment.fromJson(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Assignment> updateAssignment(Assignment assignment) async {
    try {
      final response = await _client
          .from('assignments')
          .update(assignment.toJson())
          .eq('id', assignment.id)
          .select()
          .single();

      return Assignment.fromJson(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> deleteAssignment(String id) async {
    try {
      await _client.from('assignments').delete().eq('id', id);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Assignment> publishAssignment(String id) async {
    try {
      final response = await _client
          .from('assignments')
          .update({'status': 'published'})
          .eq('id', id)
          .select()
          .single();

      return Assignment.fromJson(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<Submission>> getSubmissions(String assignmentId) async {
    try {
      final response = await _client
          .from('submissions')
          .select()
          .eq('assignment_id', assignmentId)
          .order('submitted_at', ascending: false);

      return (response as List)
          .map((json) => Submission.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Submission> submitAssignment({
    required String assignmentId,
    required String content,
    List<String>? attachments,
  }) async {
    try {
      final data = {
        'assignment_id': assignmentId,
        'student_id': _currentUserId,
        'content': content,
        'attachments': attachments ?? [],
        'submitted_at': DateTime.now().toIso8601String(),
        'status': 'submitted',
      };

      final response = await _client
          .from('submissions')
          .insert(data)
          .select()
          .single();

      return Submission.fromJson(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Submission> updateSubmission(Submission submission) async {
    try {
      final response = await _client
          .from('submissions')
          .update(submission.toJson())
          .eq('id', submission.id)
          .select()
          .single();

      return Submission.fromJson(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Submission?> getMySubmission(String assignmentId) async {
    try {
      final response = await _client
          .from('submissions')
          .select()
          .eq('assignment_id', assignmentId)
          .eq('student_id', _currentUserId!)
          .maybeSingle();

      if (response == null) return null;
      return Submission.fromJson(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Stream<List<Assignment>> watchAssignments() {
    return _client
        .from('assignments')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => Assignment.fromJson(json)).toList());
  }

  /// Transforms Supabase errors into domain-specific exceptions
  Exception _handleError(dynamic error) {
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

/// Custom exception for repository errors
class RepositoryException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  RepositoryException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'RepositoryException: $message (code: $code)';
}
