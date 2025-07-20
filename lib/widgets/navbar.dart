import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  void _handleTabTap(int index) {
    if (widget.currentIndex != index) {
      widget.onIndexChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Sliding indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: 8 + ((MediaQuery.of(context).size.width - 16) / 3) * widget.currentIndex + 
                   (((MediaQuery.of(context).size.width - 16) / 3) - 48) / 2,
              top: 0,
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Navigation items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: Icons.home_outlined,
                    colorScheme: colorScheme,
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: Icons.favorite_outline,
                    colorScheme: colorScheme,
                  ),
                  _buildNavItem(
                    index: 2,
                    icon: Icons.settings_outlined,
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required ColorScheme colorScheme,
  }) {
    final isSelected = widget.currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        _handleTabTap(index);
      },
      child: SizedBox(
        width: 80,
        height: 40,
        child: Icon(
          icon,
          color: isSelected 
              ? colorScheme.primary 
              : colorScheme.onSurface.withValues(alpha: 0.6),
          size: 26,
        ),
      ),
    );
  }
} 