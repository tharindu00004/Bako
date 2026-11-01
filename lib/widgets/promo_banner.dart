import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class PromoBanner extends StatelessWidget {
  final VoidCallback onContactTap;

  const PromoBanner({
    Key? key,
    required this.onContactTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: AppColors.promoGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0x8000C2FF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyanAccent.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left Tool Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF071E4A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0x8038BDF8),
                width: 1,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.build_circle_rounded,
                color: AppColors.goldYellow,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Middle Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  AppStrings.promoTitle,
                  style: TextStyle(
                    color: AppColors.goldYellow,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  AppStrings.promoSubtitle,
                  style: TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 9.5,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          // Yellow CTA Button
          ElevatedButton(
            onPressed: onContactTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.goldYellow,
              foregroundColor: Colors.black,
              elevation: 4,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: Size.zero,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  AppStrings.promoCta,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
