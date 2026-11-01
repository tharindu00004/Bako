import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;
  final VoidCallback onAddPostTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onAddPostTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: const BoxDecoration(
        color: AppColors.darkDockNavy,
        border: Border(
          top: BorderSide(
            color: Color(0x4038BDF8),
            width: 1,
          ),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Tab 0: Home
              _buildNavItem(
                index: 0,
                icon: Icons.home_rounded,
                label: AppStrings.navHome,
              ),

              // Tab 1: Search
              _buildNavItem(
                index: 1,
                icon: Icons.search_rounded,
                label: AppStrings.navSearch,
              ),

              // Empty space for the floating center button
              const SizedBox(width: 48),

              // Tab 2: Inbox (with badge)
              _buildNavItem(
                index: 2,
                icon: Icons.chat_bubble_rounded,
                label: AppStrings.navInbox,
                badgeCount: 3,
              ),

              // Tab 3: Profile
              _buildNavItem(
                index: 3,
                icon: Icons.person_rounded,
                label: AppStrings.navProfile,
              ),
            ],
          ),

          // Glowing Floating Center (+) Button
          Positioned(
            top: -18,
            child: GestureDetector(
              onTap: onAddPostTap,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.cyanAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyanAccent.withOpacity(0.6),
                      blurRadius: 16,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    int? badgeCount,
  }) {
    final bool isSelected = currentIndex == index;
    final Color color =
        isSelected ? AppColors.cyanAccent : const Color(0xFF93C5FD);

    return InkWell(
      onTap: () => onTabSelected(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 22),
                if (badgeCount != null)
                  Positioned(
                    top: -4,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.notificationRed,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
