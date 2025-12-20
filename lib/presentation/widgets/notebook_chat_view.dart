import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/retain_learn_theme.dart';
import '../providers/chat_provider.dart';

class NotebookChatView extends ConsumerStatefulWidget {
  const NotebookChatView({super.key});

  @override
  ConsumerState<NotebookChatView> createState() => _NotebookChatViewState();
}

class _NotebookChatViewState extends ConsumerState<NotebookChatView> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock active sources
  final List<String> _activeSources = [
    "Math Assignment.pdf",
    "Report Card (Oct)",
    "Biology Notes"
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSubmitted() {
    final text = _textController.text;
    if (text.isEmpty) return;
    
    _textController.clear();
    ref.read(chatProvider.notifier).sendMessage(text);

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final messages = chatState.messages;

    return Column(
      children: [
        // 1. Context Bubbles Header
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: RetainLearnTheme.paperWhite,
            border: const Border(bottom: BorderSide(color: RetainLearnTheme.grayBorder)),
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _activeSources.length + 1,
            separatorBuilder: (ctx, i) => const SizedBox(width: 8),
            itemBuilder: (ctx, i) {
              if (i == 0) {
                 return Chip(
                  avatar: const Icon(Icons.add, size: 16, color: RetainLearnTheme.tealPrimary),
                  label: const Text("Add Source"),
                  backgroundColor: RetainLearnTheme.tealSurface,
                  side: BorderSide.none,
                  labelStyle: TextStyle(
                    color: RetainLearnTheme.tealDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              }
              final source = _activeSources[i - 1];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: RetainLearnTheme.grayBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.description_outlined, size: 14, color: RetainLearnTheme.textMedium),
                    const SizedBox(width: 6),
                    Text(
                      source,
                      style: TextStyle(fontSize: 12, color: RetainLearnTheme.textDark),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.close, size: 12, color: RetainLearnTheme.textLight),
                  ],
                ),
              );
            },
          ),
        ),

        // 2. Chat Area
        Expanded(
          child: messages.isEmpty
              ? _buildEmptyState(context)
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(24),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return _ChatBubble(message: msg);
                  },
                ),
        ),

        // 3. Input Area
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: RetainLearnTheme.paperWhite,
            border: const Border(top: BorderSide(color: RetainLearnTheme.grayBorder)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: "Ask a question about your sources...",
                    hintStyle: TextStyle(color: RetainLearnTheme.textLight),
                    filled: true,
                    fillColor: RetainLearnTheme.paperOffWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: RetainLearnTheme.grayBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: RetainLearnTheme.grayBorder),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                  onSubmitted: (_) => _handleSubmitted(),
                ),
              ),
              const SizedBox(width: 12),
              FloatingActionButton(
                onPressed: _handleSubmitted,
                backgroundColor: RetainLearnTheme.tealPrimary,
                elevation: 0,
                mini: true,
                child: chatState.isLoading
                  ? const SizedBox(
                      width: 16, 
                      height: 16, 
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    )
                  : const Icon(Icons.arrow_upward, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: RetainLearnTheme.tealSurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, size: 48, color: RetainLearnTheme.tealPrimary),
          ),
          const SizedBox(height: 24),
          Text(
            "NotebookLM Assistant",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Ask questions, summarize documents, or get study tips.",
            textAlign: TextAlign.center,
            style: TextStyle(color: RetainLearnTheme.textMedium),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isUser) ...[
                   Icon(Icons.auto_awesome, size: 16, color: RetainLearnTheme.tealPrimary),
                   const SizedBox(width: 8),
                   Text("Assistant", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: RetainLearnTheme.textDark)),
                ],
                if (isUser)
                   Text("You", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: RetainLearnTheme.textMedium)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser ? RetainLearnTheme.paperOffWhite : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: isUser ? Border.all(color: RetainLearnTheme.grayBorder) : null,
              ),
              child: isUser 
                ? Text(message.content, style: TextStyle(color: RetainLearnTheme.textDark, height: 1.5))
                : MarkdownBody(
                    data: message.content + (message.isStreaming ? " ▋" : ""), // Blinking cursor effect
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(color: RetainLearnTheme.textDark, height: 1.6, fontSize: 16),
                      h1: TextStyle(color: RetainLearnTheme.textDark, fontWeight: FontWeight.bold, fontSize: 24),
                      h2: TextStyle(color: RetainLearnTheme.textDark, fontWeight: FontWeight.bold, fontSize: 20),
                      code: TextStyle(backgroundColor: RetainLearnTheme.paperOffWhite, fontFamily: 'monospace'),
                      codeblockDecoration: BoxDecoration(
                        color: RetainLearnTheme.paperOffWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
