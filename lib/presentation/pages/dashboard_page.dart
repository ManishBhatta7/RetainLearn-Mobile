import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/theme/retain_learn_theme.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Supabase.instance.client.auth.currentUser;
    final displayName = user?.userMetadata?['full_name'] ?? 'Scholar';

    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: RetainLearnTheme.textMedium,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    displayName,
                    style: Theme.of(context).textTheme.displayMedium,
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
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                   // Large Tile: Chat Assistant
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: _DashboardCard(
                      title: 'AI Assistant',
                      subtitle: 'Ask about your assignments',
                      icon: Icons.chat_bubble_outline,
                      color: RetainLearnTheme.tealPrimary,
                      onTap: () => context.go('/chat'),
                      isLarge: true,
                    ),
                  ),
                  
                  // Medium Tile: Upload
                  StaggeredGridTile.count(
                    crossAxisCellCount: MediaQuery.of(context).size.width > 600 ? 1: 1,
                    mainAxisCellCount: 1,
                    child: _DashboardCard(
                      title: 'Upload Source',
                      subtitle: 'PDFs, Images',
                      icon: Icons.upload_file,
                      color: Colors.blueAccent,
                      onTap: () => context.go('/sources'),
                    ),
                  ),

                   // Medium Tile: Assignments
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: _DashboardCard(
                      title: 'Assignments',
                      subtitle: '3 Pending',
                      icon: Icons.assignment_outlined,
                      color: Colors.orangeAccent,
                      onTap: () => context.go('/assignments'),
                    ),
                  ),

                  // Medium Tile: Report Analysis
                  StaggeredGridTile.count(
                    crossAxisCellCount: MediaQuery.of(context).size.width > 600 ? 2 : 2,
                    mainAxisCellCount: 1,
                    child: _DashboardCard(
                      title: 'Report Analysis',
                      subtitle: 'Track your academic growth',
                      icon: Icons.analytics_outlined,
                      color: Colors.purpleAccent,
                      onTap: () => context.go('/tools/report-upload'), // Assume route exists or creates placeholder
                    ),
                  ),
                  
                   // Small Tile: Voice
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: _DashboardCard(
                      title: 'Voice Reader',
                      subtitle: 'Listen & Learn',
                      icon: Icons.record_voice_over_outlined,
                      color: Colors.pinkAccent,
                      onTap: () => context.go('/tools/voice-reading'),
                    ),
                  ),

                   // Small Tile: Profile
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: _DashboardCard(
                      title: 'My Profile',
                      subtitle: 'Stats & Settings',
                      icon: Icons.person_outline,
                      color: RetainLearnTheme.textDark,
                      onTap: () => context.go('/profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isLarge;

  const _DashboardCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: RetainLearnTheme.grayBorder.withOpacity(0.5)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                isLarge ? color.withOpacity(0.05) : Colors.white,
              ],
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: isLarge ? 32 : 24),
              ),
              const Spacer(),
              Text(
                title,
                style: isLarge
                    ? Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)
                    : Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: RetainLearnTheme.textMedium,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
