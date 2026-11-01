import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../models/machinery_item.dart';
import '../models/video_item.dart';
import '../widgets/top_header_banner.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_grid.dart';
import '../widgets/machinery_card.dart';
import '../widgets/featured_video_card.dart';
import '../widgets/promo_banner.dart';
import '../widgets/bottom_nav_bar.dart';
import 'detail_screen.dart';
import 'post_ad_screen.dart';
import 'login_screen.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  List<MachineryItem> _machineryList = MachineryItem.getSampleItems();
  final VideoItem _featuredVideo = VideoItem.getSampleFeatured();

  void _onFavoriteToggle(int index) {
    setState(() {
      _machineryList[index].isFavorite = !_machineryList[index].isFavorite;
    });

    final item = _machineryList[index];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          item.isFavorite
              ? '${item.title} මගේ ලැයිස්තුවට එක් කරන ලදී ❤️'
              : '${item.title} මගේ ලැයිස්තුවෙන් ඉවත් කරන ලදී',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.surfaceNavy,
      ),
    );
  }

  void _openDetailScreen(MachineryItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailScreen(item: item),
      ),
    );
  }

  void _openPostAdScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PostAdScreen(),
      ),
    );
  }

  void _showAccountMenu() {
    final user = AuthService().currentUser;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceNavy,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: user?.isSuperAdmin == true
                        ? AppColors.goldYellow
                        : AppColors.cyanAccent,
                    child: Icon(
                      user?.isSuperAdmin == true
                          ? Icons.shield_rounded
                          : Icons.person_rounded,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? 'සාමාජික පරිශීලක',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        user?.isSuperAdmin == true
                            ? '👑 Super Admin'
                            : '👤 සාමාජික ගිණුම (Member)',
                        style: TextStyle(
                          color: user?.isSuperAdmin == true
                              ? AppColors.goldYellow
                              : AppColors.cyanAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: Color(0x3338BDF8), height: 24),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.redAccent),
                title: const Text('මගේ ප්‍රියතම දැන්වීම් (Favorites)',
                    style: TextStyle(color: Colors.white, fontSize: 13)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('ගිණුමෙන් ඉවත් වන්න (Log Out)',
                    style: TextStyle(color: Colors.redAccent, fontSize: 13)),
                onTap: () {
                  Navigator.pop(context);
                  AuthService().logout();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNotificationSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceNavy,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'දැනුම්දීම් (Notifications)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.info_outline, color: AppColors.cyanAccent),
                title: Text(
                  'නව JCB 3DX මාදිලියක් විකිණීමට එක් විය.',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                subtitle: Text(
                  'මිනිත්තු 15 කට පෙර',
                  style: TextStyle(color: AppColors.textIceBlue, fontSize: 11),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundNavy,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Banner
                    TopHeaderBanner(
                      onNotificationTap: _showNotificationSheet,
                      onMenuTap: _showAccountMenu,
                    ),

                    // Floating Search Bar over Header
                    Transform.translate(
                      offset: const Offset(0, -18),
                      child: SearchBarWidget(
                        onChanged: (val) {},
                        onFilterTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('ෆිල්ටර් තේරීම')),
                          );
                        },
                      ),
                    ),

                    // 5-Action Category Grid
                    CategoryGrid(
                      onSelectCategory: (categoryKey) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('තේරීම: $categoryKey')),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Section 1: නවතම ලැයිස්තු (Latest Listings)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            AppStrings.sectionLatest,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: const [
                                Text(
                                  AppStrings.viewAll,
                                  style: TextStyle(
                                    color: AppColors.cyanAccent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.cyanAccent,
                                  size: 11,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Horizontal Scrolling Machinery Cards
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _machineryList.length,
                        itemBuilder: (context, index) {
                          final item = _machineryList[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: MachineryCard(
                              item: item,
                              onTap: () => _openDetailScreen(item),
                              onFavoriteToggle: () => _onFavoriteToggle(index),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Section 2: විශේෂිත වීඩියෝ (Featured Video)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            AppStrings.sectionVideos,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: const [
                                Text(
                                  AppStrings.viewAll,
                                  style: TextStyle(
                                    color: AppColors.cyanAccent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.cyanAccent,
                                  size: 11,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    FeaturedVideoCard(
                      video: _featuredVideo,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'ධාවනය: ${_featuredVideo.title} - ${_featuredVideo.subtitle}',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Spare Parts Promo Banner
                    PromoBanner(
                      onContactTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('අමතර කොටස් අංශය: 077 123 4567 අමතන්න'),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            BottomNavBar(
              currentIndex: _currentNavIndex,
              onTabSelected: (index) {
                if (index == 3) {
                  _showAccountMenu();
                  return;
                }
                setState(() {
                  _currentNavIndex = index;
                });
              },
              onAddPostTap: _openPostAdScreen,
            ),
          ],
        ),
      ),
    );
  }
}
