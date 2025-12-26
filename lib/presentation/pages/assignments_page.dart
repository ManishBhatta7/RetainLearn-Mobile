import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/theme/retain_learn_theme.dart';
import '../../data/providers/repository_providers.dart';
import '../../domain/models/assignment.dart';
import '../../domain/models/user.dart';
import '../widgets/create_assignment_dialog.dart';

/// Assignments Page - NotebookLM Teal Aesthetic
class AssignmentsPage extends ConsumerStatefulWidget {
  const AssignmentsPage({super.key});

  @override
  ConsumerState<AssignmentsPage> createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends ConsumerState<AssignmentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  String? _selectedSubject;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assignmentsAsync = ref.watch(assignmentsNotifierProvider);
    final user = ref.watch(currentUserProvider);
    final isTeacher = user?.role == UserRole.teacher;

    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(
              'Assignments',
              style: GoogleFonts.merriweather(
                fontWeight: FontWeight.bold,
                color: RetainLearnTheme.textDark,
              ),
            ),
            backgroundColor: RetainLearnTheme.paperOffWhite,
            elevation: 0,
            floating: true,
            pinned: true,
            actions: [
               IconButton(
                icon: Icon(Icons.search, color: RetainLearnTheme.textMedium),
                onPressed: _showSearchDialog,
              ),
              IconButton(
                icon: Icon(Icons.filter_list, color: RetainLearnTheme.textMedium),
                onPressed: _showFilterDialog,
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              labelColor: RetainLearnTheme.tealPrimary,
              unselectedLabelColor: RetainLearnTheme.textMedium,
              indicatorColor: RetainLearnTheme.tealPrimary,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
        ],
        body: assignmentsAsync.when(
          data: (assignments) => _buildAssignmentsList(assignments),
          loading: () => Center(
            child: CircularProgressIndicator(color: RetainLearnTheme.tealPrimary),
          ),
          error: (error, stack) => _buildErrorState(error),
        ),
      ),
      floatingActionButton: isTeacher ? FloatingActionButton.extended(
        onPressed: _showCreateAssignmentDialog,
        backgroundColor: RetainLearnTheme.tealPrimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Create', style: TextStyle(color: Colors.white)),
      ) : null,
    );
  }

  Widget _buildAssignmentsList(List<Assignment> assignments) {
    // Filter assignments
    var filtered = assignments.where((a) {
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        if (!a.title.toLowerCase().contains(query) &&
            !(a.description?.toLowerCase().contains(query) ?? false)) {
          return false;
        }
      }
      if (_selectedSubject != null && a.subjectArea != _selectedSubject) {
        return false;
      }
      return true;
    }).toList();

    // Filter by tab
    final now = DateTime.now();
    switch (_tabController.index) {
      case 1: // Active
        filtered = filtered.where((a) {
          final dueDate = a.dueDate;
          return dueDate != null && dueDate.isAfter(now);
        }).toList();
        break;
      case 2: // Completed
        filtered = filtered.where((a) {
          final dueDate = a.dueDate;
          return dueDate != null && dueDate.isBefore(now);
        }).toList();
        break;
    }

    if (filtered.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      color: RetainLearnTheme.tealPrimary,
      onRefresh: () => ref.read(assignmentsNotifierProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filtered.length,
        itemBuilder: (context, index) => _AssignmentCard(assignment: filtered[index]),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 64, color: RetainLearnTheme.textLight),
          const SizedBox(height: 16),
          Text(
            'No assignments found',
            style: TextStyle(
              fontSize: 18,
              color: RetainLearnTheme.textMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
            const SizedBox(height: 16),
            Text(
              'Failed to load assignments',
              style: TextStyle(
                fontSize: 16,
                color: RetainLearnTheme.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: RetainLearnTheme.textMedium),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => ref.read(assignmentsNotifierProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: OutlinedButton.styleFrom(
                foregroundColor: RetainLearnTheme.tealPrimary,
                side: BorderSide(color: RetainLearnTheme.tealPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateAssignmentDialog() {
    showDialog(
      context: context,
      builder: (_) => const CreateAssignmentDialog(),
    ).then((created) {
      if (created == true) {
        ref.read(assignmentsNotifierProvider.notifier).refresh();
      }
    });
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search', style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search by title...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (val) => setState(() => _searchQuery = val),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _searchQuery = '');
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            style: FilledButton.styleFrom(backgroundColor: RetainLearnTheme.tealPrimary),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: RetainLearnTheme.paperWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter by Subject',
              style: GoogleFonts.merriweather(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: RetainLearnTheme.textDark,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _FilterChip(
                  label: 'All',
                  selected: _selectedSubject == null,
                  onSelected: () {
                    setState(() => _selectedSubject = null);
                    Navigator.pop(context);
                  },
                ),
                ...['Math', 'Science', 'History', 'English', 'Art'].map(
                  (subject) => _FilterChip(
                    label: subject,
                    selected: _selectedSubject == subject.toLowerCase(),
                    onSelected: () {
                      setState(() => _selectedSubject = subject.toLowerCase());
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final Assignment assignment;

  const _AssignmentCard({required this.assignment});

  @override
  Widget build(BuildContext context) {
    final isOverdue = assignment.dueDate?.isBefore(DateTime.now()) ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: RetainLearnTheme.paperWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: RetainLearnTheme.grayBorder),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to detail
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            assignment.title,
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: RetainLearnTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (assignment.description != null)
                            Text(
                              assignment.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: RetainLearnTheme.textMedium,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _StatusBadge(status: assignment.status, isOverdue: isOverdue),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (assignment.subjectArea != null)
                      _SubjectChip(subject: assignment.subjectArea!),
                    const Spacer(),
                    if (assignment.dueDate != null) ...[
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: isOverdue ? Colors.red : RetainLearnTheme.textLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('MMM d').format(assignment.dueDate!),
                        style: TextStyle(
                          fontSize: 12,
                          color: isOverdue ? Colors.red : RetainLearnTheme.textMedium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final AssignmentStatus status;
  final bool isOverdue;

  const _StatusBadge({required this.status, required this.isOverdue});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    if (isOverdue) {
      color = Colors.red;
      label = 'Overdue';
    } else if (status == AssignmentStatus.draft) {
      color = Colors.orange;
      label = 'Draft';
    } else {
      color = Colors.green;
      label = 'Active';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color.withOpacity(0.8),
        ),
      ),
    );
  }
}

class _SubjectChip extends StatelessWidget {
  final String subject;

  const _SubjectChip({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: RetainLearnTheme.tealSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        subject.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: RetainLearnTheme.tealDark,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      backgroundColor: RetainLearnTheme.paperOffWhite,
      selectedColor: RetainLearnTheme.tealPrimary.withOpacity(0.15),
      checkmarkColor: RetainLearnTheme.tealPrimary,
      labelStyle: TextStyle(
        color: selected ? RetainLearnTheme.tealPrimary : RetainLearnTheme.textDark,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? RetainLearnTheme.tealPrimary : RetainLearnTheme.grayBorder,
        ),
      ),
    );
  }
}
