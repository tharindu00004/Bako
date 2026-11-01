import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String name;
  final String identifier; // phone or email
  final String password;
  final VerificationMethod method;
  final String? district;

  const VerificationScreen({
    Key? key,
    required this.name,
    required this.identifier,
    required this.password,
    required this.method,
    this.district,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _otpController =
      TextEditingController(text: '739281');
  bool _isLoading = false;

  Future<void> _verifyOtp() async {
    final code = _otpController.text.trim();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('කරුණාකර අංක 6 කින් යුත් OTP කේතය ඇතුළත් කරන්න.'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final success = await AuthService().verifyAndRegisterMember(
      name: widget.name,
      identifier: widget.identifier,
      password: widget.password,
      otpCode: code,
      method: widget.method,
      district: widget.district,
    );

    setState(() => _isLoading = false);

    if (mounted && success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('ගිණුම සාර්ථකව තහවුරු විය! සාදරයෙන් පිළිගනිමු! ✅'),
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPhone = widget.method == VerificationMethod.phone;

    return Scaffold(
      backgroundColor: AppColors.backgroundNavy,
      appBar: AppBar(
        backgroundColor: const Color(0xFF071C49),
        elevation: 0,
        title: const Text(
          'ගිණුම තහවුරු කිරීම (Verification)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Header
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF071E4A),
                  border: Border.all(color: AppColors.cyanAccent, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyanAccent.withOpacity(0.3),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    isPhone
                        ? Icons.sms_rounded
                        : Icons.mark_email_read_rounded,
                    color: AppColors.cyanAccent,
                    size: 38,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              const Text(
                'OTP කේතය ඇතුළත් කරන්න',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: AppColors.textIceBlue,
                    fontSize: 12.5,
                  ),
                  children: [
                    TextSpan(
                      text: isPhone
                          ? 'ඔබගේ දුරකථන අංක '
                          : 'ඔබගේ ඊමේල් ලිපිනය ',
                    ),
                    TextSpan(
                      text: widget.identifier,
                      style: const TextStyle(
                        color: AppColors.goldYellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: ' වෙත අංක 6 කින් යුත් තහවුරු කිරීමේ කේතයක් යවා ඇත.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 6-Digit OTP Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C2458),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.cyanAccent,
                    width: 1.5,
                  ),
                ),
                child: TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    letterSpacing: 12,
                    fontWeight: FontWeight.w900,
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: '------',
                    hintStyle: TextStyle(
                      color: Color(0x4D38BDF8),
                      letterSpacing: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Demo Code Pill
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0x33F59E0B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x66F59E0B)),
                ),
                child: const Text(
                  '💡 පරීක්ෂා කිරීමේ Demo OTP කේතය: 739281',
                  style: TextStyle(
                    color: AppColors.goldYellow,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'තහවුරු කර ගිණුම සක්‍රිය කරන්න',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // Resend Option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'කේතය නොලැබුණාද? ',
                    style: TextStyle(color: Color(0x9993C5FD), fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('නව OTP කේතයක් යවන ලදී: 739281'),
                        ),
                      );
                    },
                    child: const Text(
                      'නැවත එවන්න (Resend Code)',
                      style: TextStyle(
                        color: AppColors.cyanAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
