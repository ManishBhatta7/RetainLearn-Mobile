import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/retain_learn_theme.dart';
import '../providers/chat_provider.dart';
import '../widgets/floating_input_pill.dart';
import '../widgets/source_chip.dart';

/// Chat Page - NotebookLM-style AI chat interface
///
/// Features:
/// - Horizontal source chips bar at top
/// - Center-aligned chat messages
/// - Floating input pill at bottom
/// - Markdown rendering for AI responses
class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  // Mock active sources (in production, this comes from a provider)
  final List<_MockSource> _activeSources = [
    _MockSource(name: 'Math Assignment.pdf', type: SourceType.pdf),
    _MockSource(name: 'Report Card', type: SourceType.report),
    _MockSource(name: 'Biology Notes', type: SourceType.document),
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    
    _textController.clear();
    ref.read(chatProvider.notifier).sendMessage(text);
    _scrollToBottom();
  }

  void _scrollToBottom() {
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

    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Source chips header
            _buildSourceHeader(),
            
            // Chat messages
            Expanded(
              child: messages.isEmpty
                  ? _buildEmptyState()
                  : _buildMessageList(messages),
            ),
            
            // Floating input pill
            FloatingInputPill(
              controller: _textController,
              focusNode: _focusNode,
              hintText: 'Ask about your sources...',
              isLoading: chatState.isLoading,
              onSend: _handleSend,
              onAttachment: () {
                // TODO: Add attachment picker
              },
            ),
            
            // Safe area padding for bottom
            SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? 0 : 8),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: RetainLearnTheme.paperWhite,
        border: Border(
          bottom: BorderSide(color: RetainLearnTheme.grayBorder),
        ),
      ),
      child: Row(
        children: [
          // Add source button
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                // TODO: Add source picker
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: RetainLearnTheme.tealSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: RetainLearnTheme.tealPrimary.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 16,
                      color: RetainLearnTheme.tealPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: RetainLearnTheme.tealDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Source chips
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _activeSources.map((source) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SourceChip(
                      label: source.name,
                      type: source.type,
                      onRemove: () {
                        // TODO: Remove source
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: RetainLearnTheme.tealSurface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 48,
                color: RetainLearnTheme.tealPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'RetainLearn Assistant',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Ask questions about your sources, get study tips, or summarize your documents.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: RetainLearnTheme.textMedium,
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildSuggestionChip('Summarize my notes'),
                _buildSuggestionChip('Explain this concept'),
                _buildSuggestionChip('Create quiz questions'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        _textController.text = text;
        _focusNode.requestFocus();
      },
      backgroundColor: RetainLearnTheme.paperWhite,
      side: BorderSide(color: RetainLearnTheme.grayBorder),
      labelStyle: TextStyle(
        fontSize: 13,
        color: RetainLearnTheme.textMedium,
      ),
    );
  }

  Widget _buildMessageList(List<ChatMessage> messages) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _ChatBubble(message: message);
      },
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Avatar
          if (!isUser) ...[
            Container(
              margin: const EdgeInsets.only(right: 12, top: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: RetainLearnTheme.tealSurface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 16,
                color: RetainLearnTheme.tealPrimary,
              ),
            ),
          ],

          // Message content
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.all(isUser ? 14 : 0),
              decoration: isUser
                  ? BoxDecoration(
                      color: RetainLearnTheme.paperWhite,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: RetainLearnTheme.grayBorder),
                    )
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isUser)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Assistant',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: RetainLearnTheme.textMedium,
                        ),
                      ),
                    ),
                  isUser
                      ? Text(
                          message.content,
                          style: TextStyle(
                            fontSize: 15,
                            color: RetainLearnTheme.textDark,
                            height: 1.4,
                          ),
                        )
                      : MarkdownBody(
                          data: message.content +
                              (message.isStreaming ? ' ▋' : ''),
                          styleSheet: MarkdownStyleSheet(
                            p: RetainLearnTheme.streamingTextStyle,
                            h1: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            h2: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            code: TextStyle(
                              backgroundColor: RetainLearnTheme.paperOffWhite,
                              fontFamily: 'monospace',
                              fontSize: 14,
                            ),
                            codeblockDecoration: BoxDecoration(
                              color: RetainLearnTheme.paperOffWhite,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            listBullet: RetainLearnTheme.streamingTextStyle,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MockSource {
  final String name;
  final SourceType type;

  _MockSource({required this.name, required this.type});
}
