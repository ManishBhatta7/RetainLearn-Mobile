import '../models/classroom.dart';

/// Abstract Classroom Repository
/// 
/// Defines the contract for classroom management operations.
abstract class ClassroomRepository {
  /// Get all classrooms for the current user
  /// Students: Returns enrolled classrooms
  /// Teachers: Returns created classrooms
  Future<List<Classroom>> getClassrooms();

  /// Get a classroom by ID
  Future<Classroom?> getClassroomById(String id);

  /// Create a new classroom (teacher only)
  Future<Classroom> createClassroom(Classroom classroom);

  /// Update a classroom
  Future<Classroom> updateClassroom(Classroom classroom);

  /// Delete a classroom
  Future<void> deleteClassroom(String id);

  /// Join a classroom using join code (student only)
  Future<Classroom> joinClassroom(String joinCode);

  /// Leave a classroom (student only)
  Future<void> leaveClassroom(String classroomId);

  /// Remove a student from classroom (teacher only)
  Future<void> removeStudent(String classroomId, String studentId);

  /// Get students in a classroom (teacher only)
  Future<List<String>> getStudentIds(String classroomId);

  /// Stream of classrooms for real-time updates
  Stream<List<Classroom>> watchClassrooms();
}

/// Abstract Doubts Repository
/// 
/// Defines the contract for Q&A/doubts operations.
abstract class DoubtsRepository {
  /// Get all doubts for the current user
  Future<List<Doubt>> getDoubts();

  /// Get a doubt by ID
  Future<Doubt?> getDoubtById(String id);

  /// Create a new doubt/question
  Future<Doubt> createDoubt(Doubt doubt);

  /// Update a doubt (add answer, change status)
  Future<Doubt> updateDoubt(Doubt doubt);

  /// Delete a doubt
  Future<void> deleteDoubt(String id);

  /// Get AI-generated answer for a doubt
  Future<String> getAiAnswer(String question, {String? subject});

  /// Stream of doubts for real-time updates
  Stream<List<Doubt>> watchDoubts();
}
