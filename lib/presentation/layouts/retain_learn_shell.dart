import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/retain_learn_theme.dart';

/// Responsive Shell for RetainLearn
///
/// Features:
/// - Mobile: Floating BottomNavigationBar with glassmorphism
/// - Tablet/Desktop: NavigationRail with header branding
class RetainLearnShell extends ConsumerStatefulWidget {
  final Widget child;

  const RetainLearnShell({super.key, required this.child});

  @override
  ConsumerState<RetainLearnShell> createState() => _RetainLearnShellState();
}

class _RetainLearnShellState extends ConsumerState<RetainLearnShell> {
  int _currentIndex = 0;

  static const List<_NavItem> _navItems = [
    _NavItem(
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      label: 'Home',
      path: '/dashboard',
    ),
    _NavItem(
      icon: Icons.auto_awesome_outlined,
      activeIcon: Icons.auto_awesome,
      label: 'Assistant',
      path: '/chat',
    ),
    _NavItem(
      icon: Icons.assignment_outlined,
      activeIcon: Icons.assignment,
      label: 'Tasks',
      path: '/assignments',
    ),
    _NavItem(
      icon: Icons.folder_outlined,
      activeIcon: Icons.folder,
      label: 'Sources',
      path: '/sources',
    ),
    _NavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
      path: '/profile',
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateIndex();
  }

  void _updateIndex() {
    try {
      final location = GoRouterState.of(context).matchedLocation;
      for (int i = 0; i < _navItems.length; i++) {
        if (location.startsWith(_navItems[i].path)) {
          if (_currentIndex != i) {
            setState(() => _currentIndex = i);
          }
          break;
        }
      }
    } catch (_) {
      // Ignore context issues during build
    }
  }

  void _onItemTapped(int index) {
    if (index != _currentIndex) {
      context.go(_navItems[index].path);
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateIndex();
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    if (isDesktop) {
      return _buildDesktopLayout();
    }
    return _buildMobileLayout();
  }

  /// Desktop Layout: NavigationRail with header branding
  Widget _buildDesktopLayout() {
    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 240,
            decoration: BoxDecoration(
              color: RetainLearnTheme.paperWhite,
              border: Border(
                right: BorderSide(color: RetainLearnTheme.grayBorder),
              ),
            ),
            child: Column(
              children: [
                // Header branding
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: RetainLearnTheme.tealSurface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.auto_stories,
                          color: RetainLearnTheme.tealPrimary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'RetainLearn',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Divider(height: 1),
                
                // Navigation items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    itemCount: _navItems.length,
                    itemBuilder: (context, index) {
                      final item = _navItems[index];
                      final isSelected = _currentIndex == index;
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Material(
                          color: isSelected 
                              ? RetainLearnTheme.tealSurface 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () => _onItemTapped(index),
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16, 
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected ? item.activeIcon : item.icon,
                                    color: isSelected 
                                        ? RetainLearnTheme.tealPrimary 
                                        : RetainLearnTheme.textLight,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    item.label,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected 
                                          ? FontWeight.w600 
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? RetainLearnTheme.tealDark
                                          : RetainLearnTheme.textMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Main content
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }

  /// Mobile Layout: Floating glassmorphic bottom navigation
  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      body: widget.child,
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                color: RetainLearnTheme.paperWhite.withOpacity(0.9),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: RetainLearnTheme.grayBorder.withOpacity(0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_navItems.length, (index) {
                    final item = _navItems[index];
                    final isSelected = _currentIndex == index;
                    
                    return GestureDetector(
                      onTap: () => _onItemTapped(index),
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: isSelected ? 16 : 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? RetainLearnTheme.tealSurface 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isSelected ? item.activeIcon : item.icon,
                              color: isSelected 
                                  ? RetainLearnTheme.tealPrimary 
                                  : RetainLearnTheme.textLight,
                              size: 22,
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 8),
                              Text(
                                item.label,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: RetainLearnTheme.tealDark,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String path;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.path,
  });
}
