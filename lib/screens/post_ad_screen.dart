import 'package:flutter/material.dart';
import '../constants/colors.dart';

class PostAdScreen extends StatefulWidget {
  const PostAdScreen({Key? key}) : super(key: key);

  @override
  State<PostAdScreen> createState() => _PostAdScreenState();
}

class _PostAdScreenState extends State<PostAdScreen> {
  String _adType = 'sale';
  String _selectedDistrict = 'කුරුණෑගල';

  final List<String> _districts = [
    'කුරුණෑගල (Kurunegala)',
    'නුවර (Kandy)',
    'ගම්පහ (Gampaha)',
    'කොළඹ (Colombo)',
    'අනුරාධපුර (Anuradhapura)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundNavy,
      appBar: AppBar(
        backgroundColor: const Color(0xFF071C49),
        title: const Text('දැන්වීමක් පළ කරන්න (Post Ad)'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ad Type Switch (Sale / Rent)
            const Text(
              'දැන්වීමේ වර්ගය (Listing Type):',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _adType = 'sale';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _adType == 'sale'
                          ? AppColors.badgeSale
                          : const Color(0xFF0C2458),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('විකිණීමට (Sale)'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _adType = 'rent';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _adType == 'rent'
                          ? AppColors.badgeRent
                          : const Color(0xFF0C2458),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('කුලියට (Rent)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Machine Model Name
            _buildInputField('යන්ත්‍රයේ මාදිලිය (Machine Model)',
                'උදා: JCB 3DX, CAT 320D'),
            const SizedBox(height: 14),

            // Year & Hours
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                      'වර්ෂය (Year)', '2018',
                      keyboardType: TextInputType.number),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInputField(
                      'ධාවන පැය (Hours)', '3200',
                      keyboardType: TextInputType.number),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Price Field
            _buildInputField(
              'මිල (Price in LKR)',
              'රු. 4,250,000',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 14),

            // District Selection
            const Text(
              'ස්ථානය / දිස්ත්‍රික්කය (Location):',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF0C2458),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0x6638BDF8)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _districts.first,
                  dropdownColor: const Color(0xFF071C49),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  isExpanded: true,
                  items: _districts.map((d) {
                    return DropdownMenuItem(value: d, child: Text(d));
                  }).toList(),
                  onChanged: (val) {},
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('ඔබගේ දැන්වීම සාර්ථකව ඇතුළත් විය! ✅'),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cyanAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'දැන්වීම පළ කරන්න (Submit Ad)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(color: Color(0x6693C5FD), fontSize: 12),
            filled: true,
            fillColor: const Color(0xFF0C2458),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0x6638BDF8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.cyanAccent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
