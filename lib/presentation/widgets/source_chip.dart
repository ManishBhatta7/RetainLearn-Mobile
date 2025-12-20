import 'package:flutter/material.dart';
import '../../core/theme/retain_learn_theme.dart';

/// Source Chip - Glassmorphic pill for displaying active sources
///
/// Matches NotebookLM's context pill design with:
/// - Translucent background
/// - Thin border
/// - Source-type icon and color
class SourceChip extends StatelessWidget {
  final String label;
  final SourceType type;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final bool isSelected;

  const SourceChip({
    super.key,
    required this.label,
    this.type = SourceType.document,
    this.onTap,
    this.onRemove,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor();
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? color.withOpacity(0.1) 
              : RetainLearnTheme.paperWhite.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? color.withOpacity(0.3) 
                : RetainLearnTheme.grayBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getTypeIcon(),
              size: 14,
              color: color,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected 
                    ? color 
                    : RetainLearnTheme.textMedium,
              ),
            ),
            if (onRemove != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: RetainLearnTheme.textLight,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getTypeColor() {
    switch (type) {
      case SourceType.pdf:
        return RetainLearnTheme.sourceAssignment;
      case SourceType.image:
        return RetainLearnTheme.sourceReport;
      case SourceType.assignment:
        return RetainLearnTheme.sourceAssignment;
      case SourceType.report:
        return RetainLearnTheme.sourceReport;
      case SourceType.quiz:
        return RetainLearnTheme.sourceQuiz;
      case SourceType.essay:
        return RetainLearnTheme.sourceEssay;
      case SourceType.document:
      default:
        return RetainLearnTheme.textMedium;
    }
  }

  IconData _getTypeIcon() {
    switch (type) {
      case SourceType.pdf:
        return Icons.picture_as_pdf;
      case SourceType.image:
        return Icons.image;
      case SourceType.assignment:
        return Icons.assignment;
      case SourceType.report:
        return Icons.analytics;
      case SourceType.quiz:
        return Icons.quiz;
      case SourceType.essay:
        return Icons.edit_document;
      case SourceType.document:
      default:
        return Icons.description;
    }
  }
}

enum SourceType {
  pdf,
  image,
  assignment,
  report,
  quiz,
  essay,
  document,
}
