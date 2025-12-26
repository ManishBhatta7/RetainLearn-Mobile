import 'package:supabase_flutter/supabase_flutter.dart';

/// GeminiService - Direct connection to Gemini Edge Functions
///
/// Provides clean interface for AI interactions without repository abstraction
/// for rapid debugging and testing.
class GeminiService {
  static final SupabaseClient _client = Supabase.instance.client;

  /// Chat with Gemini AI using context files
  ///
  /// [message] - The user's message/question
  /// [contextFiles] - List of source/file IDs to use as context
  ///
  /// Returns the AI response as a String
  /// Throws [GeminiException] on failure
  static Future<String> chatWithGemini(
    String message, {
    List<String> contextFiles = const [],
  }) async {
    try {
      final response = await _client.functions.invoke(
        'gemini-chat',
        body: {
          'message': message,
          'contextFiles': contextFiles,
        },
      );

      // Check for success
      if (response.status != 200) {
        throw GeminiException(
          'Edge Function returned status ${response.status}',
          statusCode: response.status,
        );
      }

      // Extract response text
      final data = response.data;
      if (data == null) {
        throw GeminiException('Empty response from Gemini');
      }

      // Handle different response formats
      if (data is Map) {
        return data['response']?.toString() ??
            data['text']?.toString() ??
            data['message']?.toString() ??
            data.toString();
      }

      return data.toString();
    } on FunctionException catch (e) {
      throw GeminiException(
        'Supabase Function Error: ${e.reasonPhrase ?? e.toString()}',
        statusCode: e.status,
        details: e.details?.toString(),
      );
    } catch (e) {
      if (e is GeminiException) rethrow;
      throw GeminiException('Unexpected error: $e');
    }
  }

  /// Analyze a report card image
  ///
  /// [imageBase64] - Base64 encoded image data
  /// [filename] - Original filename
  ///
  /// Returns analyzed data as Map
  static Future<Map<String, dynamic>> analyzeReport({
    required String imageBase64,
    required String filename,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'analyze-report',
        body: {
          'image': imageBase64,
          'filename': filename,
        },
      );

      if (response.status != 200) {
        throw GeminiException(
          'Report analysis failed: ${response.status}',
          statusCode: response.status,
        );
      }

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }

      throw GeminiException('Invalid response format from analyze-report');
    } on FunctionException catch (e) {
      throw GeminiException(
        'Analysis Error: ${e.reasonPhrase ?? e.toString()}',
        statusCode: e.status,
      );
    } catch (e) {
      if (e is GeminiException) rethrow;
      throw GeminiException('Analysis failed: $e');
    }
  }

  /// Test the backend connection
  ///
  /// Returns true if connection is successful
  static Future<bool> testConnection() async {
    try {
      // Simple test - check if we can reach the function
      final response = await chatWithGemini('Hello, this is a connection test.');
      return response.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}

/// Custom exception for Gemini-related errors
class GeminiException implements Exception {
  final String message;
  final int? statusCode;
  final String? details;

  GeminiException(this.message, {this.statusCode, this.details});

  @override
  String toString() {
    if (statusCode != null) {
      return 'GeminiException [$statusCode]: $message${details != null ? '\nDetails: $details' : ''}';
    }
    return 'GeminiException: $message';
  }
}
