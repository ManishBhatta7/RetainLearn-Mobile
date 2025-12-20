import 'package:flutter/material.dart';
import '../../core/theme/retain_learn_theme.dart';
import '../widgets/notebook_chat_view.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      // No AppBar, NotebookChatView handles the headers
      body: const SafeArea(
        child: NotebookChatView(),
      ),
    );
  }
}
