import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/theme/retain_learn_theme.dart';
import '../widgets/studio_card.dart';

/// Dashboard Page - NotebookLM Studio Grid
///
/// Features:
/// - Personalized welcome header
/// - Masonry grid of StudioCards and MetricCards
/// - Responsive layout (2 columns mobile, 4 columns desktop)
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Supabase.instance.client.auth.currentUser;
    final displayName = user?.userMetadata?['full_name'] ?? 'Scholar';
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2);

    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.of(context).padding.top + 24,
              24,
              24,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: RetainLearnTheme.textMedium,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    displayName,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ),

          // Bento Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: StaggeredGrid.count(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  // Large: AI Assistant
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: StudioCard(
                      title: 'AI Assistant',
                      subtitle: 'Chat with your learning sources',
                      icon: Icons.auto_awesome,
                      accentColor: RetainLearnTheme.tealPrimary,
                      isLarge: true,
                      onTap: () => context.go('/chat'),
                    ),
                  ),

                  // Upload Sources
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: StudioCard(
                      title: 'Upload',
                      subtitle: 'Add new sources',
                      icon: Icons.add_circle_outline,
                      accentColor: RetainLearnTheme.sourceAssignment,
                      onTap: () => context.go('/sources'),
                    ),
                  ),

                  // Assignments
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: StudioCard(
                      title: 'Tasks',
                      subtitle: '3 pending',
                      icon: Icons.assignment_outlined,
                      accentColor: Colors.orange,
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '3',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      onTap: () => context.go('/assignments'),
                    ),
                  ),

                  // Report Analysis - Wide
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: StudioCard(
                      title: 'Report Analysis',
                      subtitle: 'Scan and track your grades',
                      icon: Icons.analytics_outlined,
                      accentColor: RetainLearnTheme.sourceReport,
                      onTap: () => context.go('/tools/report-upload'),
                    ),
                  ),

                  // Voice Reader
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: StudioCard(
                      title: 'Voice Reader',
                      subtitle: 'Listen & learn',
                      icon: Icons.record_voice_over_outlined,
                      accentColor: RetainLearnTheme.sourceEssay,
                      onTap: () => context.go('/tools/voice-reading'),
                    ),
                  ),

                  // Profile
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: StudioCard(
                      title: 'Profile',
                      subtitle: 'Stats & settings',
                      icon: Icons.person_outline,
                      accentColor: RetainLearnTheme.textMedium,
                      onTap: () => context.go('/profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom padding for floating nav
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}
