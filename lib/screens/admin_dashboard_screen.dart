import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final List<Map<String, dynamic>> _pendingListings = [
    {
      'id': 'p1',
      'title': 'Komatsu PC200-8 Excavator',
      'specs': '2019 • පැය 2800 • රු. 6,800,000',
      'seller': 'සුනිල් ප්‍රනාන්දු (071 889 9001)',
      'time': 'අද 09:15 AM',
      'type': 'sale',
      'isApproved': false,
    },
    {
      'id': 'p2',
      'title': 'JCB 3DX Super Backhoe',
      'specs': 'දිනක කුලිය • රු. 38,000 / දිනය',
      'seller': 'නිමල් බණ්ඩාර (නුවර)',
      'time': 'ඊයේ 04:30 PM',
      'type': 'rent',
      'isApproved': false,
    },
    {
      'id': 'p3',
      'title': 'CAT 428F Backhoe Loader',
      'specs': '2017 • පැය 4100 • රු. 4,500,000',
      'seller': 'ලසන්ත විජේසිංහ (ගම්පහ)',
      'time': 'පෙරේදා',
      'type': 'sale',
      'isApproved': false,
    },
  ];

  void _approveItem(int index) {
    setState(() {
      _pendingListings[index]['isApproved'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[800],
        content: Text(
          '${_pendingListings[index]['title']} දැන්වීම අනුමත කරන ලදී! ✅',
        ),
      ),
    );
  }

  void _rejectItem(int index) {
    final title = _pendingListings[index]['title'];
    setState(() {
      _pendingListings.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[800],
        content: Text('$title දැන්වීම ප්‍රතික්ෂේප විය ✕'),
      ),
    );
  }

  void _logout() {
    AuthService().logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _previewMemberApp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundNavy,
      appBar: AppBar(
        backgroundColor: const Color(0xFF071C49),
        elevation: 2,
        leading: const Icon(Icons.shield_rounded, color: AppColors.goldYellow),
        title: Row(
          children: [
            const Text(
              'Super Admin',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.goldYellow,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'PANEL',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Switch to Member Mode Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _previewMemberApp,
                icon: const Icon(Icons.visibility_rounded, size: 18),
                label: const Text('සාමාජික දසුන බලන්න (Preview Member App)'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.cyanAccent,
                  side: const BorderSide(color: Color(0x6600C2FF)),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // KPI Metrics Grid (2x2)
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    title: 'අනුමැතියට ඇති (Pending)',
                    value: '12',
                    subtitle: 'දැන්වීම් 12ක් පරීක්ෂාවට',
                    color: AppColors.goldYellow,
                    icon: Icons.pending_actions_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricCard(
                    title: 'සක්‍රිය දැන්වීම් (Active)',
                    value: '158',
                    subtitle: 'JCB 85, CAT 50, වෙනත් 23',
                    color: AppColors.cyanAccent,
                    icon: Icons.check_circle_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    title: 'සාමාජිකයින් (Members)',
                    value: '1,240',
                    subtitle: '+28 අද ලියාපදිංචි විය',
                    color: Colors.purpleAccent,
                    icon: Icons.people_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricCard(
                    title: 'ගනුදෙනු විමසීම්',
                    value: '3,450',
                    subtitle: 'රු. 85M සම්පූර්ණ අගය',
                    color: Colors.emeraldAccent,
                    icon: Icons.phone_in_talk_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Pending Approvals Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'තහවුරු කිරීමට ඇති දැන්වීම් (Approvals Queue)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0x33F59E0B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_pendingListings.length} නව',
                    style: const TextStyle(
                      color: AppColors.goldYellow,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Approvals List
            if (_pendingListings.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.cardNavy,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'සියලුම දැන්වීම් අනුමත කර ඇත! 🎉',
                  style: TextStyle(color: Colors.white70),
                ),
              )
            else
              ...List.generate(_pendingListings.length, (index) {
                final item = _pendingListings[index];
                final bool isApproved = item['isApproved'] == true;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.cardNavy,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isApproved
                          ? Colors.green.withOpacity(0.5)
                          : const Color(0x4D38BDF8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: item['type'] == 'sale'
                                  ? AppColors.badgeSale
                                  : AppColors.badgeRent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item['type'] == 'sale'
                                  ? 'විකිණීමට (Sale)'
                                  : 'කුලියට (Rent)',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            item['time'],
                            style: const TextStyle(
                              color: AppColors.goldYellow,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['specs'],
                        style: const TextStyle(
                          color: AppColors.textIceBlue,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'විකුණුම්කරු: ${item['seller']}',
                        style: const TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontSize: 10.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (isApproved)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '✓ සාර්ථකව අනුමත විය',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _approveItem(index),
                                icon: const Icon(Icons.check_rounded, size: 16),
                                label: const Text('අනුමත කරන්න (Approve)'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[700],
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _rejectItem(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[800],
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('ප්‍රතික්ෂේප'),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              }),

            const SizedBox(height: 16),

            // Admin Tools Shortcuts
            const Text(
              'පරිපාලක සැකසුම් (Admin Tools)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildToolButton(
                    '👥 සාමාජික කළමනාකරණය',
                    'පරිශීලකයින් 1,240ක්',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildToolButton(
                    '⚙️ වර්ග සහ සැකසුම්',
                    'JCB, CAT, Tata, කොටස්',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardNavy,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(icon, color: color, size: 16),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0x9993C5FD), fontSize: 9.5),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardNavy,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x4D38BDF8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.cyanAccent,
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0x9993C5FD), fontSize: 10),
          ),
        ],
      ),
    );
  }
}
