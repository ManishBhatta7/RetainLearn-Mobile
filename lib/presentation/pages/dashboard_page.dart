import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/theme/retain_learn_theme.dart';
import '../../data/providers/repository_providers.dart';
import '../widgets/studio_card.dart';
import '../widgets/debug_button.dart';

/// Dashboard Page - NotebookLM Studio Grid
///
/// Features:
/// - Personalized welcome header with user info
/// - Masonry grid of StudioCards and MetricCards
/// - Responsive layout (2 columns mobile, 4 columns desktop)
/// - Debug FAB for testing backend connection
/// - Sign Out button for auth testing
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Supabase.instance.client.auth.currentUser;
    final displayName = user?.userMetadata?['full_name'] ?? 'Scholar';
    final userEmail = user?.email ?? 'Not logged in';
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2);

    // Safety check - if no user, show loading
    if (user == null) {
      return Scaffold(
        backgroundColor: RetainLearnTheme.paperOffWhite,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: RetainLearnTheme.tealPrimary,
              ),
              const SizedBox(height: 16),
              Text(
                'Loading...',
                style: TextStyle(color: RetainLearnTheme.textMedium),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      floatingActionButton: const DebugFAB(),
      body: CustomScrollView(
        slivers: [
          // Header with User Info
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
                  // User Info Row
                  Row(
                    children: [
                      Expanded(
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
                      // Sign Out Button
                      _buildSignOutButton(context, ref),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Auth Status Card
                  _buildAuthStatusCard(context, userEmail),
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

  /// Build the Sign Out button
  Widget _buildSignOutButton(BuildContext context, WidgetRef ref) {
    return OutlinedButton.icon(
      onPressed: () async {
        // Show confirmation dialog
        final shouldSignOut = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Sign Out'),
            content: const Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: FilledButton.styleFrom(
                  backgroundColor: RetainLearnTheme.tealPrimary,
                ),
                child: const Text('Sign Out'),
              ),
            ],
          ),
        );

        if (shouldSignOut == true) {
          final authRepo = ref.read(authRepositoryProvider);
          await authRepo.signOut();
          if (context.mounted) {
            context.go('/login');
          }
        }
      },
      icon: Icon(Icons.logout, size: 18, color: RetainLearnTheme.textMedium),
      label: Text(
        'Sign Out',
        style: TextStyle(color: RetainLearnTheme.textMedium),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: RetainLearnTheme.grayBorder),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  /// Build the auth status card showing current user email
  Widget _buildAuthStatusCard(BuildContext context, String email) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: RetainLearnTheme.tealSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: RetainLearnTheme.tealPrimary.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.verified_user,
            color: RetainLearnTheme.tealPrimary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Logged in as:',
                  style: TextStyle(
                    fontSize: 11,
                    color: RetainLearnTheme.textMedium,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: RetainLearnTheme.tealDark,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: Colors.green.shade600,
            size: 20,
          ),
        ],
      ),
    );
  }
}
