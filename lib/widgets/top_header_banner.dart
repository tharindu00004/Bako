import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class TopHeaderBanner extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onMenuTap;

  const TopHeaderBanner({
    Key? key,
    required this.onNotificationTap,
    required this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo and App Name
              Row(
                children: [
                  // Circular Badge
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF03153B),
                      border: Border.all(color: AppColors.cyanAccent, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cyanAccent.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.agriculture_rounded,
                        color: AppColors.goldYellow,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title and Subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'HIT ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textWhite,
                              ),
                            ),
                            TextSpan(
                              text: 'BAKO',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                color: AppColors.cyanAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        AppStrings.appTagline1,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textIceBlue,
                        ),
                      ),
                      const Text(
                        AppStrings.appTagline2,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xBF93C5FD),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Notification & Hamburger Menu
              Row(
                children: [
                  // Bell with badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D2D68).withOpacity(0.7),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0x6638BDF8)),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_active_rounded,
                              color: AppColors.goldYellow, size: 22),
                          onPressed: onNotificationTap,
                          constraints: const BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: AppColors.notificationRed,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  // Hamburger Button
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D2D68).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0x6638BDF8)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.menu_rounded,
                          color: Colors.white, size: 24),
                      onPressed: onMenuTap,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Heavy Machinery Header Graphic
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              height: 48,
              child: const Icon(
                Icons.fire_truck_rounded,
                color: AppColors.goldYellow,
                size: 46,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
