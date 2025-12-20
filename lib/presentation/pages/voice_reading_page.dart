import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../data/services/voice_recorder_service.dart';
import '../../data/services/tts_service.dart';

/// Voice Reading Page
/// 
/// Demonstrates voice input (speech-to-text) and output (text-to-speech).
/// Uses the VoiceRecorderService for speech recognition.
class VoiceReadingPage extends ConsumerStatefulWidget {
  const VoiceReadingPage({super.key});

  @override
  ConsumerState<VoiceReadingPage> createState() => _VoiceReadingPageState();
}

class _VoiceReadingPageState extends ConsumerState<VoiceReadingPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isSpeaking = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final voiceState = ref.watch(voiceRecordingProvider);
    final voiceNotifier = ref.read(voiceRecordingProvider.notifier);

    // Update text when voice recognition completes
    if (voiceState.isCompleted && voiceState.text != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _textController.text = voiceState.text!;
        voiceNotifier.reset();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Reading'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Instructions Card
              _InstructionsCard(),
              const SizedBox(height: 24),

              // Text Input Area
              Expanded(
                child: _TextInputArea(
                  controller: _textController,
                  isListening: voiceState.isListening,
                  partialResult: voiceState.text,
                ),
              ),
              const SizedBox(height: 16),

              // Control Buttons
              _ControlButtons(
                isListening: voiceState.isListening,
                isSpeaking: _isSpeaking,
                text: _textController.text,
                onStartListening: () => voiceNotifier.startRecording(),
                onStopListening: () => voiceNotifier.stopRecording(),
                onSpeak: _handleSpeak,
                onStopSpeaking: _handleStopSpeaking,
                onClear: () {
                  _textController.clear();
                  setState(() {});
                },
              ),

              // Error Display
              if (voiceState.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _ErrorBanner(error: voiceState.error!),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSpeak() async {
    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter or record some text first')),
      );
      return;
    }

    final tts = ref.read(ttsServiceProvider);
    setState(() => _isSpeaking = true);
    await tts.speak(_textController.text);
    setState(() => _isSpeaking = false);
  }

  void _handleStopSpeaking() async {
    final tts = ref.read(ttsServiceProvider);
    await tts.stop();
    setState(() => _isSpeaking = false);
  }
}

class _InstructionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.mic,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Voice Reading Practice',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Record your reading or type text to have it read aloud',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextInputArea extends StatelessWidget {
  final TextEditingController controller;
  final bool isListening;
  final String? partialResult;

  const _TextInputArea({
    required this.controller,
    required this.isListening,
    this.partialResult,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Text',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Stack(
            children: [
              TextField(
                controller: controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: isListening
                      ? 'Listening...'
                      : 'Type or speak your text here...',
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              if (isListening && partialResult != null)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            partialResult!,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ControlButtons extends StatelessWidget {
  final bool isListening;
  final bool isSpeaking;
  final String text;
  final VoidCallback onStartListening;
  final VoidCallback onStopListening;
  final VoidCallback onSpeak;
  final VoidCallback onStopSpeaking;
  final VoidCallback onClear;

  const _ControlButtons({
    required this.isListening,
    required this.isSpeaking,
    required this.text,
    required this.onStartListening,
    required this.onStopListening,
    required this.onSpeak,
    required this.onStopSpeaking,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Record Button
        Expanded(
          child: _ActionButton(
            onPressed: isListening ? onStopListening : onStartListening,
            icon: isListening ? Icons.stop : Icons.mic,
            label: isListening ? 'Stop' : 'Record',
            isActive: isListening,
            gradient: isListening
                ? const LinearGradient(colors: [AppColors.error, Color(0xFFDC2626)])
                : AppColors.primaryGradient,
          ),
        ),
        const SizedBox(width: 12),

        // Speak Button
        Expanded(
          child: _ActionButton(
            onPressed: isSpeaking ? onStopSpeaking : onSpeak,
            icon: isSpeaking ? Icons.stop : Icons.volume_up,
            label: isSpeaking ? 'Stop' : 'Speak',
            isActive: isSpeaking,
            gradient: const LinearGradient(
              colors: [AppColors.success, Color(0xFF16A34A)],
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Clear Button
        IconButton.filled(
          onPressed: onClear,
          icon: const Icon(Icons.clear),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool isActive;
  final LinearGradient gradient;

  const _ActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: gradient.colors.first.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String error;

  const _ErrorBanner({required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
