import 'package:flutter/material.dart';
import '../../core/theme/notebook_theme.dart';

/// Source type enum for card styling
enum SourceType {
  assignment,
  report,
  quiz,
  reading,
  essay,
  doubt,
  classroom,
}

/// Status enum for source cards
enum SourceStatus {
  pending,
  completed,
  inProgress,
  overdue,
}

/// NotebookSourceCard - Primary content unit in NotebookLM style
/// 
/// A clean, minimal card for displaying "sources" like:
/// - Assignments
/// - Report Cards
/// - Quiz Results
/// - Reading Sessions
class NotebookSourceCard extends StatelessWidget {
  /// Type of source - determines color scheme
  final SourceType type;
  
  /// Title of the source
  final String title;
  
  /// Optional subtitle/description
  final String? subtitle;
  
  /// Optional metadata (date, subject, etc.)
  final String? meta;
  
  /// Status indicator
  final SourceStatus? status;
  
  /// Optional score/grade (0-100)
  final int? score;
  
  /// Click handler
  final VoidCallback? onTap;
  
  /// Custom icon override
  final IconData? icon;
  
  /// Compact mode
  final bool compact;

  const NotebookSourceCard({
    super.key,
    required this.type,
    required this.title,
    this.subtitle,
    this.meta,
    this.status,
    this.score,
    this.onTap,
    this.icon,
    this.compact = false,
  });

  // Type-specific styling
  IconData get _defaultIcon {
    switch (type) {
      case SourceType.assignment:
        return Icons.description_outlined;
      case SourceType.report:
        return Icons.bar_chart;
      case SourceType.quiz:
        return Icons.quiz_outlined;
      case SourceType.reading:
        return Icons.menu_book_outlined;
      case SourceType.essay:
        return Icons.article_outlined;
      case SourceType.doubt:
        return Icons.chat_bubble_outline;
      case SourceType.classroom:
        return Icons.group_outlined;
    }
  }

  SourceTypeColors get _colors {
    return NotebookTheme.sourceTypeColors[type.name] ?? 
      SourceTypeColors(
        primary: NotebookTheme.gray500,
        background: NotebookTheme.gray100,
        border: NotebookTheme.gray300,
      );
  }

  Widget _buildStatusIndicator() {
    if (status == null) return const SizedBox.shrink();
    
    IconData statusIcon;
    Color statusColor;
    String statusLabel;
    
    switch (status!) {
      case SourceStatus.pending:
        statusIcon = Icons.schedule;
        statusColor = NotebookTheme.gray500;
        statusLabel = 'Pending';
        break;
      case SourceStatus.completed:
        statusIcon = Icons.check_circle_outline;
        statusColor = NotebookTheme.success;
        statusLabel = 'Completed';
        break;
      case SourceStatus.inProgress:
        statusIcon = Icons.timelapse;
        statusColor = NotebookTheme.info;
        statusLabel = 'In Progress';
        break;
      case SourceStatus.overdue:
        statusIcon = Icons.error_outline;
        statusColor = NotebookTheme.error;
        statusLabel = 'Overdue';
        break;
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(statusIcon, size: 14, color: statusColor),
        const SizedBox(width: 4),
        Text(
          statusLabel,
          style: TextStyle(
            fontSize: 12,
            color: statusColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreBadge() {
    if (score == null) return const SizedBox.shrink();
    
    Color bgColor;
    Color textColor;
    
    if (score! >= 80) {
      bgColor = const Color(0xFFD1FAE5);
      textColor = const Color(0xFF047857);
    } else if (score! >= 60) {
      bgColor = const Color(0xFFFEF3C7);
      textColor = const Color(0xFFB45309);
    } else {
      bgColor = const Color(0xFFFEE2E2);
      textColor = const Color(0xFFB91C1C);
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$score%',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = _colors;
    final displayIcon = icon ?? _defaultIcon;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: NotebookTheme.borderRadiusXl,
        child: Container(
          padding: EdgeInsets.all(compact ? 16 : 20),
          decoration: BoxDecoration(
            color: NotebookTheme.white,
            borderRadius: NotebookTheme.borderRadiusXl,
            border: Border(
              left: BorderSide(color: colors.border, width: 4),
              top: BorderSide(color: NotebookTheme.gray100, width: 1),
              right: BorderSide(color: NotebookTheme.gray100, width: 1),
              bottom: BorderSide(color: NotebookTheme.gray100, width: 1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: compact ? 40 : 48,
                height: compact ? 40 : 48,
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: NotebookTheme.borderRadiusMd,
                ),
                child: Icon(
                  displayIcon,
                  color: colors.primary,
                  size: compact ? 20 : 24,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: compact ? 14 : 15,
                        fontWeight: FontWeight.w600,
                        color: NotebookTheme.gray900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Subtitle
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: compact ? 12 : 13,
                          color: NotebookTheme.gray500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    
                    // Footer: Meta, Status, Score
                    if (meta != null || status != null || score != null) ...[
                      SizedBox(height: compact ? 8 : 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (meta != null)
                            Text(
                              meta!,
                              style: TextStyle(
                                fontSize: 12,
                                color: NotebookTheme.gray400,
                              ),
                            ),
                          _buildStatusIndicator(),
                          _buildScoreBadge(),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              
              // Chevron indicator
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: NotebookTheme.gray300,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// NotebookSourceCardSkeleton - Loading state for source cards
class NotebookSourceCardSkeleton extends StatelessWidget {
  final bool compact;
  
  const NotebookSourceCardSkeleton({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(compact ? 16 : 20),
      decoration: BoxDecoration(
        color: NotebookTheme.white,
        borderRadius: NotebookTheme.borderRadiusXl,
        border: Border.all(color: NotebookTheme.gray100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon skeleton
          Container(
            width: compact ? 40 : 48,
            height: compact ? 40 : 48,
            decoration: BoxDecoration(
              color: NotebookTheme.gray100,
              borderRadius: NotebookTheme.borderRadiusMd,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: NotebookTheme.gray100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 150,
                  decoration: BoxDecoration(
                    color: NotebookTheme.gray100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 12,
                  width: 80,
                  decoration: BoxDecoration(
                    color: NotebookTheme.gray100,
                    borderRadius: BorderRadius.circular(4),
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

/// NotebookMetricCard - Stats display card
class NotebookMetricCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final VoidCallback? onTap;

  const NotebookMetricCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: NotebookTheme.borderRadiusXl,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: NotebookTheme.white,
            borderRadius: NotebookTheme.borderRadiusXl,
            border: Border.all(color: NotebookTheme.gray100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: NotebookTheme.borderRadiusMd,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: NotebookTheme.gray900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: NotebookTheme.gray500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// NotebookQuickAction - Gradient action button
class NotebookQuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Gradient gradient;
  final VoidCallback? onTap;

  const NotebookQuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: NotebookTheme.borderRadiusMd,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: NotebookTheme.borderRadiusMd,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
