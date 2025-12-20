import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

/// Voice Recording Service
/// 
/// Wraps the speech_to_text package to provide a clean API for voice input.
/// This is injected into the UI via Riverpod for testability and decoupling.
class VoiceRecorderService {
  final SpeechToText _speechToText;
  bool _isInitialized = false;
  bool _isListening = false;

  VoiceRecorderService() : _speechToText = SpeechToText();

  /// Whether the service is currently listening
  bool get isListening => _isListening;

  /// Whether speech recognition is available on this device
  bool get isAvailable => _isInitialized;

  /// Initialize the speech recognition service
  /// 
  /// Must be called before using any other methods.
  /// Returns true if initialization was successful.
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    // Request microphone permission
    final permissionStatus = await Permission.microphone.request();
    if (!permissionStatus.isGranted) {
      throw VoiceServiceException(
        'Microphone permission denied. Please enable it in settings.',
        VoiceServiceErrorType.permissionDenied,
      );
    }

    try {
      _isInitialized = await _speechToText.initialize(
        onError: (error) {
          _isListening = false;
        },
        onStatus: (status) {
          _isListening = status == 'listening';
        },
      );
      return _isInitialized;
    } catch (e) {
      throw VoiceServiceException(
        'Failed to initialize speech recognition: $e',
        VoiceServiceErrorType.initializationFailed,
      );
    }
  }

  /// Start listening for voice input
  /// 
  /// [onResult] is called when speech is recognized
  /// [onPartialResult] is called for intermediate results (optional)
  /// [localeId] is the language locale (e.g., 'en_US', 'hi_IN')
  Future<void> startListening({
    required void Function(String text) onResult,
    void Function(String text)? onPartialResult,
    String localeId = 'en_US',
    Duration? listenFor,
    Duration? pauseFor,
  }) async {
    if (!_isInitialized) {
      final success = await initialize();
      if (!success) {
        throw VoiceServiceException(
          'Speech recognition not available on this device',
          VoiceServiceErrorType.notAvailable,
        );
      }
    }

    if (_isListening) {
      await stopListening();
    }

    try {
      _isListening = true;
      await _speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
          } else {
            onPartialResult?.call(result.recognizedWords);
          }
        },
        localeId: localeId,
        listenFor: listenFor ?? const Duration(seconds: 30),
        pauseFor: pauseFor ?? const Duration(seconds: 3),
        partialResults: onPartialResult != null,
        cancelOnError: true,
        listenMode: ListenMode.confirmation,
      );
    } catch (e) {
      _isListening = false;
      throw VoiceServiceException(
        'Failed to start listening: $e',
        VoiceServiceErrorType.listeningFailed,
      );
    }
  }

  /// Stop listening for voice input
  Future<void> stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      _isListening = false;
    }
  }

  /// Cancel the current listening session
  Future<void> cancel() async {
    await _speechToText.cancel();
    _isListening = false;
  }

  /// Get available locales for speech recognition
  Future<List<LocaleName>> getAvailableLocales() async {
    if (!_isInitialized) {
      await initialize();
    }
    return _speechToText.locales();
  }

  /// Dispose of resources
  void dispose() {
    _speechToText.cancel();
    _isListening = false;
    _isInitialized = false;
  }
}

/// Voice service error types
enum VoiceServiceErrorType {
  permissionDenied,
  notAvailable,
  initializationFailed,
  listeningFailed,
}

/// Custom exception for voice service errors
class VoiceServiceException implements Exception {
  final String message;
  final VoiceServiceErrorType type;

  VoiceServiceException(this.message, this.type);

  @override
  String toString() => 'VoiceServiceException: $message';
}

/// =============================================================================
/// RIVERPOD PROVIDERS
/// =============================================================================

/// Provider for VoiceRecorderService
final voiceRecorderServiceProvider = Provider<VoiceRecorderService>((ref) {
  final service = VoiceRecorderService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for tracking if voice recognition is listening
final isVoiceListeningProvider = StateProvider<bool>((ref) => false);

/// Provider for the current recognized text
final recognizedTextProvider = StateProvider<String>((ref) => '');

/// Notifier for managing voice recording state
class VoiceRecordingNotifier extends StateNotifier<VoiceRecordingState> {
  final VoiceRecorderService _service;

  VoiceRecordingNotifier(this._service)
      : super(const VoiceRecordingState.initial());

  Future<void> startRecording({String localeId = 'en_US'}) async {
    state = const VoiceRecordingState.initializing();

    try {
      await _service.startListening(
        onResult: (text) {
          state = VoiceRecordingState.completed(text);
        },
        onPartialResult: (text) {
          state = VoiceRecordingState.listening(partialResult: text);
        },
        localeId: localeId,
      );
      state = const VoiceRecordingState.listening();
    } catch (e) {
      state = VoiceRecordingState.error(e.toString());
    }
  }

  Future<void> stopRecording() async {
    await _service.stopListening();
    // State will be updated by the onResult callback
  }

  void reset() {
    state = const VoiceRecordingState.initial();
  }
}

/// State for voice recording
class VoiceRecordingState {
  final VoiceRecordingStatus status;
  final String? text;
  final String? error;

  const VoiceRecordingState._({
    required this.status,
    this.text,
    this.error,
  });

  const VoiceRecordingState.initial()
      : this._(status: VoiceRecordingStatus.idle);

  const VoiceRecordingState.initializing()
      : this._(status: VoiceRecordingStatus.initializing);

  const VoiceRecordingState.listening({String? partialResult})
      : this._(status: VoiceRecordingStatus.listening, text: partialResult);

  const VoiceRecordingState.completed(String result)
      : this._(status: VoiceRecordingStatus.completed, text: result);

  const VoiceRecordingState.error(String errorMessage)
      : this._(status: VoiceRecordingStatus.error, error: errorMessage);

  bool get isListening => status == VoiceRecordingStatus.listening;
  bool get hasError => status == VoiceRecordingStatus.error;
  bool get isCompleted => status == VoiceRecordingStatus.completed;
}

enum VoiceRecordingStatus {
  idle,
  initializing,
  listening,
  completed,
  error,
}

/// Provider for VoiceRecordingNotifier
final voiceRecordingProvider =
    StateNotifierProvider<VoiceRecordingNotifier, VoiceRecordingState>((ref) {
  final service = ref.read(voiceRecorderServiceProvider);
  return VoiceRecordingNotifier(service);
});
