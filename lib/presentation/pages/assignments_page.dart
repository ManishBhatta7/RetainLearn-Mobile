import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../data/providers/repository_providers.dart';
import '../../domain/models/assignment.dart';

/// Assignments Page
/// 
/// Demonstrates how to consume the AssignmentRepository via Riverpod.
/// Note: This page has NO knowledge of Supabase - it only interacts
/// with the abstract repository through providers.
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
    // Watch the assignments state from the repository
    // The UI doesn't know this comes from Supabase!
    final assignmentsAsync = ref.watch(assignmentsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: assignmentsAsync.when(
        data: (assignments) => _buildAssignmentsList(assignments),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(error),
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildAssignmentsList(List<Assignment> assignments) {
    // Filter assignments based on search and filters
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
      onRefresh: () => ref.read(assignmentsNotifierProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filtered.length,
        itemBuilder: (context, index) => _AssignmentCard(
          assignment: filtered[index],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No assignments found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pull down to refresh',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
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
            const Icon(
              Icons.error_outline,
              size: 80,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load assignments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(assignmentsNotifierProvider.notifier).refresh();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _buildFab() {
    // Check if user is a teacher
    final user = ref.watch(currentUserProvider);
    if (user?.role.name == 'teacher') {
      return FloatingActionButton.extended(
        onPressed: _showCreateAssignmentDialog,
        icon: const Icon(Icons.add),
        label: const Text('Create'),
        backgroundColor: AppColors.primary,
      );
    }
    return null;
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Assignments'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search by title or description...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() => _searchQuery = value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _searchQuery = '');
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter by Subject',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                _FilterChip(
                  label: 'All',
                  selected: _selectedSubject == null,
                  onSelected: () {
                    setState(() => _selectedSubject = null);
                    Navigator.pop(context);
                  },
                ),
                _FilterChip(
                  label: 'Math',
                  selected: _selectedSubject == 'math',
                  onSelected: () {
                    setState(() => _selectedSubject = 'math');
                    Navigator.pop(context);
                  },
                ),
                _FilterChip(
                  label: 'Science',
                  selected: _selectedSubject == 'science',
                  onSelected: () {
                    setState(() => _selectedSubject = 'science');
                    Navigator.pop(context);
                  },
                ),
                // Add more subjects as needed
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateAssignmentDialog() {
    // TODO: Implement assignment creation dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create assignment coming soon!')),
    );
  }
}

/// Assignment Card Widget
class _AssignmentCard extends ConsumerWidget {
  final Assignment assignment;

  const _AssignmentCard({required this.assignment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOverdue = assignment.dueDate?.isBefore(DateTime.now()) ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Navigate to assignment detail
          // context.push('/assignments/${assignment.id}');
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      assignment.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  _StatusBadge(status: assignment.status, isOverdue: isOverdue),
                ],
              ),
              if (assignment.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  assignment.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
              ],
              const SizedBox(height: 12),
              // Footer
              Row(
                children: [
                  if (assignment.subjectArea != null)
                    _SubjectChip(subject: assignment.subjectArea!),
                  const Spacer(),
                  if (assignment.dueDate != null) ...[
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: isOverdue ? AppColors.error : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDueDate(assignment.dueDate!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isOverdue
                                ? AppColors.error
                                : Colors.grey.shade600,
                          ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.inDays == 0) {
      return 'Due today';
    } else if (difference.inDays == 1) {
      return 'Due tomorrow';
    } else if (difference.inDays < 0) {
      return 'Overdue';
    } else if (difference.inDays < 7) {
      return 'Due in ${difference.inDays} days';
    } else {
      return 'Due ${date.day}/${date.month}';
    }
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
      color = AppColors.error;
      label = 'Overdue';
    } else if (status == AssignmentStatus.draft) {
      color = Colors.grey;
      label = 'Draft';
    } else {
      color = AppColors.success;
      label = 'Active';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
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
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        subject.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
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
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
    );
  }
}
