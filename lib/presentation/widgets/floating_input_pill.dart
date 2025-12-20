import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/retain_learn_theme.dart';

/// Floating Input Pill - NotebookLM-style chat input
///
/// Features:
/// - Stadium/pill shape
/// - Glassmorphism effect
/// - Attachment and send buttons
/// - Floating shadow
class FloatingInputPill extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onSend;
  final VoidCallback? onAttachment;
  final bool isLoading;
  final FocusNode? focusNode;

  const FloatingInputPill({
    super.key,
    this.controller,
    this.hintText = 'Ask a question...',
    this.onSend,
    this.onAttachment,
    this.isLoading = false,
    this.focusNode,
  });

  @override
  State<FloatingInputPill> createState() => _FloatingInputPillState();
}

class _FloatingInputPillState extends State<FloatingInputPill> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
    _hasText = _controller.text.isNotEmpty;
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty && !widget.isLoading) {
      widget.onSend?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: RetainLearnTheme.paperWhite.withOpacity(0.95),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: RetainLearnTheme.grayBorder,
              ),
            ),
            child: Row(
              children: [
                // Attachment button
                if (widget.onAttachment != null)
                  IconButton(
                    onPressed: widget.onAttachment,
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: RetainLearnTheme.textLight,
                    ),
                    padding: const EdgeInsets.only(left: 12),
                    constraints: const BoxConstraints(),
                  ),
                
                // Text field
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: widget.focusNode,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: RetainLearnTheme.textLight,
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: widget.onAttachment != null ? 8 : 20,
                        vertical: 14,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 15,
                      color: RetainLearnTheme.textDark,
                    ),
                    maxLines: 4,
                    minLines: 1,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _handleSend(),
                  ),
                ),
                
                // Send button
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: widget.isLoading
                        ? Container(
                            margin: const EdgeInsets.all(8),
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: RetainLearnTheme.tealPrimary,
                            ),
                          )
                        : IconButton(
                            onPressed: _hasText ? _handleSend : null,
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _hasText
                                    ? RetainLearnTheme.tealPrimary
                                    : RetainLearnTheme.grayBorder,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_upward,
                                size: 18,
                                color: _hasText
                                    ? Colors.white
                                    : RetainLearnTheme.textLight,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
