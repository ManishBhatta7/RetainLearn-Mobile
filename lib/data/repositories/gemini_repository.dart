import 'dart:convert';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class GeminiRepository {
  final SupabaseClient _supabase;

  GeminiRepository(this._supabase);

  /// Sends a chat message to Gemini and returns a stream of the response.
  /// 
  /// Utilizes the 'gemini-chat' Edge Function.
  /// Currently sends a single request and yield the result, 
  /// but designed to support `Response.stream` if adapted backend-side.
  Stream<String> sendChatMessage({
    required String message,
    required List<String> contextIds,
  }) async* {
    try {
      // NOTE: true streaming requires backend to return text/event-stream
      // and client to use http.Client requesting that stream.
      // supabase.functions.invoke waits for the full response by default.
      // 
      // For now, we await the full response and simulate streaming/yield it.
      
      final response = await _supabase.functions.invoke(
        'gemini-chat',
        body: {
          'message': message,
          'contextFiles': contextIds,
        },
      );

      if (response.status != 200) {
        throw Exception('Failed to get response: ${response.status}');
      }
      
      final data = response.data;
      String text = '';
      
      if (data is Map && data.containsKey('response')) {
        text = data['response'];
      } else if (data is Map && data.containsKey('text')) {
         text = data['text'];
      } else {
        text = data.toString();
      }

      // Yield the text. Context: The UI will handle the "Typewriter" animation effect.
      yield text;
      
    } catch (e) {
      throw Exception('Gemini Error: $e');
    }
  }

  /// Analyzes a report card image using 'analyze-report' Edge Function.
  Future<Map<String, dynamic>> analyzeReport(File imageFile) async {
    try {
      // 1. Upload image to Storage (optional, or send base64)
      // For this implementation, we assume the edge function expects base64 or 
      // we upload first. Let's send Base64 for simplicity if small, 
      // or better: Upload to 'reports' bucket then send reference.
      
      final bytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(bytes);

      final response = await _supabase.functions.invoke(
        'analyze-report',
        body: {
          'image': base64Image,
          'filename': imageFile.path.split('/').last,
        },
      );

      if (response.status != 200) {
        throw Exception('Analysis failed: ${response.status}');
      }

      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Analysis Error: $e');
    }
  }
}
