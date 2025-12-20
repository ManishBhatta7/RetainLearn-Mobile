import 'package:flutter/material.dart';
import '../../core/theme/retain_learn_theme.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: RetainLearnTheme.textLight),
            const SizedBox(height: 16),
            Text(
              "AI Assistant",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              "Select a source to start chatting",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: RetainLearnTheme.textMedium,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
