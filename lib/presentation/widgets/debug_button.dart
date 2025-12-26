import 'package:flutter/material.dart';
import '../../core/theme/retain_learn_theme.dart';
import '../../data/services/gemini_service.dart';

/// Debug Button Widget - Temporary test widget for backend connection
///
/// Displays a button that tests the Gemini Edge Function connection
/// and shows results via SnackBar
class DebugButton extends StatefulWidget {
  const DebugButton({super.key});

  @override
  State<DebugButton> createState() => _DebugButtonState();
}

class _DebugButtonState extends State<DebugButton> {
  bool _isLoading = false;

  Future<void> _testBackend() async {
    setState(() => _isLoading = true);

    try {
      final response = await GeminiService.chatWithGemini(
        'Hello! This is a connection test from the Flutter app.',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '✅ Backend Connected!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      response.length > 100
                          ? '${response.substring(0, 100)}...'
                          : response,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade700,
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } on GeminiException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '❌ Error ${e.statusCode ?? ''}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      e.message,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Unexpected Error: $e'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: _isLoading ? null : _testBackend,
      icon: _isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.bug_report),
      label: Text(_isLoading ? 'Testing...' : 'Test Backend'),
      style: FilledButton.styleFrom(
        backgroundColor: RetainLearnTheme.tealPrimary,
        foregroundColor: Colors.white,
      ),
    );
  }
}

/// Inline debug FAB - Can be added to any screen for quick testing
class DebugFAB extends StatelessWidget {
  const DebugFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showDebugDialog(context),
      icon: const Icon(Icons.developer_mode),
      label: const Text('Debug'),
      backgroundColor: RetainLearnTheme.tealPrimary,
    );
  }

  void _showDebugDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backend Connection Test'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Test connection to Gemini Edge Functions'),
            SizedBox(height: 20),
            DebugButton(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
