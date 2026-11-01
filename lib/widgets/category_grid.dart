import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class CategoryItemData {
  final String title;
  final IconData icon;
  final String categoryKey;

  const CategoryItemData({
    required this.title,
    required this.icon,
    required this.categoryKey,
  });
}

class CategoryGrid extends StatelessWidget {
  final Function(String) onSelectCategory;

  const CategoryGrid({
    Key? key,
    required this.onSelectCategory,
  }) : super(key: key);

  static const List<CategoryItemData> categories = [
    CategoryItemData(
      title: AppStrings.catBuy,
      icon: Icons.front_loader,
      categoryKey: 'buy',
    ),
    CategoryItemData(
      title: AppStrings.catRent,
      icon: Icons.precision_manufacturing_rounded,
      categoryKey: 'rent',
    ),
    CategoryItemData(
      title: AppStrings.catParts,
      icon: Icons.settings_suggest_rounded,
      categoryKey: 'parts',
    ),
    CategoryItemData(
      title: AppStrings.catVideos,
      icon: Icons.video_collection_rounded,
      categoryKey: 'videos',
    ),
    CategoryItemData(
      title: AppStrings.catMyList,
      icon: Icons.person_rounded,
      categoryKey: 'mylist',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((cat) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelectCategory(cat.categoryKey),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                decoration: BoxDecoration(
                  color: AppColors.cardNavy,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0x4D38BDF8),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF071B42),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        cat.icon,
                        color: AppColors.goldYellow,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE2E8F0),
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
