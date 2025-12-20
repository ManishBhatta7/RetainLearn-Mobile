import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/retain_learn_theme.dart';

/// Responsive Shell for RetainLearn
///
/// Tablet/Desktop: NavigationRail (Left)
/// Mobile: BottomNavigationBar
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
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Assistant',
      path: '/chat', // We will need to add this route!
    ),
    _NavItem(
      icon: Icons.assignment_outlined,
      activeIcon: Icons.assignment,
      label: 'Assignments',
      path: '/assignments',
    ),
    _NavItem(
      icon: Icons.folder_open_outlined,
      activeIcon: Icons.folder_open,
      label: 'Sources',
      path: '/sources', // New source/upload page
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
          setState(() => _currentIndex = i);
          break;
        }
      }
    } catch (_) {
      // ignore context issues during build
    }
  }

  void _onItemTapped(int index) {
    if (index != _currentIndex) {
      context.go(_navItems[index].path);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Add path listener to keep index synced
    // (In robust apps we usually listen to router state updates, but this check works for simple cases)
    _updateIndex();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop / Tablet -> Rail
        if (constraints.maxWidth > 800) {
          return Scaffold(
            backgroundColor: RetainLearnTheme.paperOffWhite,
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _onItemTapped,
                  backgroundColor: RetainLearnTheme.paperWhite,
                  labelType: NavigationRailLabelType.all,
                  groupAlignment: -0.8,
                  destinations: _navItems
                      .map((item) => NavigationRailDestination(
                            icon: Icon(item.icon),
                            selectedIcon: Icon(item.activeIcon),
                            label: Text(item.label),
                          ))
                      .toList(),
                ),
                VerticalDivider(width: 1, color: RetainLearnTheme.grayBorder),
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          );
        }

        // Mobile -> Bottom Navigation
        return Scaffold(
          body: widget.child,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: RetainLearnTheme.grayBorder)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: RetainLearnTheme.paperWhite,
              selectedItemColor: RetainLearnTheme.tealPrimary,
              unselectedItemColor: RetainLearnTheme.textLight,
              items: _navItems
                  .map((item) => BottomNavigationBarItem(
                        icon: Icon(item.icon),
                        activeIcon: Icon(item.activeIcon),
                        label: item.label,
                      ))
                  .toList(),
            ),
          ),
        );
      },
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
