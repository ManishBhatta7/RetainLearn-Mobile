import '../models/assignment.dart';

/// Abstract Assignment Repository
/// 
/// This interface defines the contract for assignment data operations.
/// The UI layer ONLY interacts with this abstract class, never with
/// the concrete implementation.
/// 
/// ## Why this pattern?
/// 
/// 1. **Decoupling**: The UI doesn't know if data comes from Supabase, 
///    a custom API, or local storage.
/// 
/// 2. **Testability**: Easy to mock for unit tests.
/// 
/// 3. **Migration Ready**: To switch from Supabase to a custom Node.js backend,
///    simply create a new `HttpAssignmentRepository` that implements this
///    interface and swap the provider binding.
/// 
/// ## Migration Example:
/// 
/// ```dart
/// // Current: Supabase
/// final assignmentRepositoryProvider = Provider<AssignmentRepository>(
///   (ref) => SupabaseAssignmentRepository(ref.read(supabaseProvider)),
/// );
/// 
/// // Future: Custom Backend
/// final assignmentRepositoryProvider = Provider<AssignmentRepository>(
///   (ref) => HttpAssignmentRepository(ref.read(httpClientProvider)),
/// );
/// ```
abstract class AssignmentRepository {
  /// Fetches all assignments for the current user
  /// 
  /// For students: Returns assignments from enrolled classrooms
  /// For teachers: Returns assignments they created
  Future<List<Assignment>> getAssignments();

  /// Fetches a single assignment by ID
  Future<Assignment?> getAssignmentById(String id);

  /// Fetches assignments for a specific classroom
  Future<List<Assignment>> getAssignmentsByClassroom(String classroomId);

  /// Creates a new assignment (teacher only)
  Future<Assignment> createAssignment(Assignment assignment);

  /// Updates an existing assignment
  Future<Assignment> updateAssignment(Assignment assignment);

  /// Deletes an assignment
  Future<void> deleteAssignment(String id);

  /// Publishes a draft assignment
  Future<Assignment> publishAssignment(String id);

  /// Fetches submissions for an assignment (teacher only)
  Future<List<Submission>> getSubmissions(String assignmentId);

  /// Submits an assignment (student only)
  Future<Submission> submitAssignment({
    required String assignmentId,
    required String content,
    List<String>? attachments,
  });

  /// Updates a submission (add feedback, score)
  Future<Submission> updateSubmission(Submission submission);

  /// Gets the current user's submission for an assignment
  Future<Submission?> getMySubmission(String assignmentId);

  /// Stream of assignments for real-time updates
  Stream<List<Assignment>> watchAssignments();
}
