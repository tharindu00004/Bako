import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/admin_credentials.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'admin_dashboard_screen.dart';
import 'verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserRole _selectedRole = UserRole.member;
  VerificationMethod _memberLoginMethod = VerificationMethod.phone; // phone or email

  final TextEditingController _phoneController =
      TextEditingController(text: '077 123 4567');
  final TextEditingController _emailController =
      TextEditingController(text: 'kasun@gmail.com');
  final TextEditingController _memberPasswordController =
      TextEditingController(text: 'password123');

  // Super Admin Exclusive Controllers
  final TextEditingController _adminEmailController =
      TextEditingController(text: AdminCredentials.email);
  final TextEditingController _adminPasswordController =
      TextEditingController(text: AdminCredentials.password);
  final TextEditingController _adminKeyController =
      TextEditingController(text: AdminCredentials.securityMasterKey);

  bool _isPasswordObscured = true;
  bool _isLoading = false;

  Future<void> _handleMemberLogin() async {
    setState(() => _isLoading = true);

    final String identifier = _memberLoginMethod == VerificationMethod.phone
        ? _phoneController.text.trim()
        : _emailController.text.trim();
    final String password = _memberPasswordController.text.trim();

    final result = await AuthService().loginMember(
      phoneOrEmail: identifier,
      password: password,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('${result['message']} (Logged in)'),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(result['message'] ?? 'Login failed'),
        ),
      );

      if (result['needsVerification'] == true) {
        _showRegisterSheet();
      }
    }
  }

  Future<void> _handleAdminLogin() async {
    setState(() => _isLoading = true);

    final result = await AuthService().loginSuperAdmin(
      email: _adminEmailController.text.trim(),
      password: _adminPasswordController.text.trim(),
      masterSecurityKey: _adminKeyController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.goldYellow,
          content: Text(
            result['message'] ?? 'Super Admin Access Granted',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(result['message'] ?? 'Access Denied'),
        ),
      );
    }
  }

  void _showRegisterSheet() {
    final nameCtrl = TextEditingController(text: 'කසුන් පෙරේරා');
    final phoneCtrl = TextEditingController(text: '077 456 7890');
    final emailCtrl = TextEditingController(text: 'kasun.new@gmail.com');
    final passCtrl = TextEditingController(text: 'pass1234');
    VerificationMethod regMethod = VerificationMethod.phone;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceNavy,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'සාමාජික ලියාපදිංචිය සහ තහවුරු කිරීම',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white70),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Toggle verification method (Phone or Email)
                    Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: const Text('දුරකථන අංකයෙන් (Phone)'),
                            selected: regMethod == VerificationMethod.phone,
                            selectedColor: AppColors.cyanAccent,
                            backgroundColor: const Color(0xFF0C2458),
                            labelStyle: TextStyle(
                              color: regMethod == VerificationMethod.phone
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            onSelected: (val) {
                              setSheetState(() => regMethod = VerificationMethod.phone);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ChoiceChip(
                            label: const Text('විද්‍යුත් තැපෑලෙන් (Email)'),
                            selected: regMethod == VerificationMethod.email,
                            selectedColor: AppColors.cyanAccent,
                            backgroundColor: const Color(0xFF0C2458),
                            labelStyle: TextStyle(
                              color: regMethod == VerificationMethod.email
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            onSelected: (val) {
                              setSheetState(() => regMethod = VerificationMethod.email);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    _buildSimpleField('සම්පූර්ණ නම (Full Name)', nameCtrl),
                    const SizedBox(height: 10),

                    if (regMethod == VerificationMethod.phone)
                      _buildSimpleField(
                        'දුරකථන අංකය (Phone Number)',
                        phoneCtrl,
                        keyboard: TextInputType.phone,
                      )
                    else
                      _buildSimpleField(
                        'විද්‍යුත් තැපෑල (Email Address)',
                        emailCtrl,
                        keyboard: TextInputType.emailAddress,
                      ),

                    const SizedBox(height: 10),
                    _buildSimpleField(
                      'මුරපදය (Set Password)',
                      passCtrl,
                      isPassword: true,
                    ),
                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.verified_rounded, size: 18),
                        onPressed: () {
                          Navigator.pop(context);
                          final chosenIdentifier =
                              regMethod == VerificationMethod.phone
                                  ? phoneCtrl.text.trim()
                                  : emailCtrl.text.trim();

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VerificationScreen(
                                name: nameCtrl.text.trim(),
                                identifier: chosenIdentifier,
                                password: passCtrl.text.trim(),
                                method: regMethod,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cyanAccent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        label: const Text(
                          'OTP කේතය ලබා ගෙන තහවුරු කරන්න',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSimpleField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textIceBlue, fontSize: 11.5),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboard,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF0C2458),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0x4038BDF8)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = _selectedRole == UserRole.superAdmin;

    return Scaffold(
      backgroundColor: AppColors.backgroundNavy,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Animated Circular Logo
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF03153B),
                  border: Border.all(
                    color: isAdmin ? AppColors.goldYellow : AppColors.cyanAccent,
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (isAdmin ? AppColors.goldYellow : AppColors.cyanAccent)
                          .withOpacity(0.35),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    isAdmin
                        ? Icons.shield_rounded
                        : Icons.agriculture_rounded,
                    color: isAdmin ? AppColors.goldYellow : AppColors.cyanAccent,
                    size: 38,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Brand Title
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'HIT ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'BAKO',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        color: AppColors.cyanAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'මිලදී ගන්න • විකුණන්න • කුලියට',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textIceBlue,
                ),
              ),
              const SizedBox(height: 20),

              // Role Toggle: Member vs Super Admin
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF05173E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0x4D38BDF8)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedRole = UserRole.member),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: !isAdmin
                                ? const Color(0xFF1D4ED8)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_rounded,
                                size: 16,
                                color: !isAdmin ? Colors.white : AppColors.textIceBlue,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'සාමාජික (Member)',
                                style: TextStyle(
                                  color: !isAdmin ? Colors.white : AppColors.textIceBlue,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedRole = UserRole.superAdmin),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: isAdmin
                                ? AppColors.goldYellow
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.security_rounded,
                                size: 16,
                                color: isAdmin ? Colors.black : AppColors.goldYellow,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Super Admin (රහස්‍ය)',
                                style: TextStyle(
                                  color: isAdmin ? Colors.black : AppColors.goldYellow,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ================= MEMBER LOGIN SECTION =================
              if (!isAdmin) ...[
                // Sub-tab: Phone vs Email Login Method
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() =>
                            _memberLoginMethod = VerificationMethod.phone),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _memberLoginMethod == VerificationMethod.phone
                                ? const Color(0x3300C2FF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _memberLoginMethod == VerificationMethod.phone
                                  ? AppColors.cyanAccent
                                  : const Color(0x3338BDF8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.phone_android_rounded,
                                  size: 15, color: AppColors.cyanAccent),
                              SizedBox(width: 4),
                              Text(
                                'දුරකථන අංකයෙන්',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() =>
                            _memberLoginMethod = VerificationMethod.email),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _memberLoginMethod == VerificationMethod.email
                                ? const Color(0x3300C2FF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _memberLoginMethod == VerificationMethod.email
                                  ? AppColors.cyanAccent
                                  : const Color(0x3338BDF8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.email_rounded,
                                  size: 15, color: AppColors.cyanAccent),
                              SizedBox(width: 4),
                              Text(
                                'විද්‍යුත් තැපෑලෙන්',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Identifier Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _memberLoginMethod == VerificationMethod.phone
                        ? 'තහවුරු කළ දුරකථන අංකය (Verified Phone):'
                        : 'තහවුරු කළ විද්‍යුත් තැපෑල (Verified Email):',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _memberLoginMethod == VerificationMethod.phone
                      ? _phoneController
                      : _emailController,
                  keyboardType: _memberLoginMethod == VerificationMethod.phone
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      _memberLoginMethod == VerificationMethod.phone
                          ? Icons.phone_rounded
                          : Icons.alternate_email_rounded,
                      color: AppColors.cyanAccent,
                      size: 18,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF0C2458),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0x6638BDF8)),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Password Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'මුරපදය (Password):',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _memberPasswordController,
                  obscureText: _isPasswordObscured,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_rounded,
                      color: AppColors.cyanAccent,
                      size: 18,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: AppColors.textIceBlue,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: const Color(0xFF0C2458),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0x6638BDF8)),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Member Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleMemberLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cyanAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 13),
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
                            'සාමාජික ලෙස ඇතුල් වන්න (Member Log In)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 14),

                // Sign Up & Verify Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ගිණුමක් නැද්ද? ',
                      style: TextStyle(color: Color(0xCC93C5FD), fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: _showRegisterSheet,
                      child: const Text(
                        'ලියාපදිංචි වී තහවුරු කරන්න (Verify & Sign Up)',
                        style: TextStyle(
                          color: AppColors.cyanAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              // ================= SUPER ADMIN EXCLUSIVE SECTION =================
              if (isAdmin) ...[
                // Security Notice Badge
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0x22F59E0B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0x88F59E0B)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.lock_person_rounded,
                          color: AppColors.goldYellow, size: 22),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'මෙම මුරපදය සහ Master Key එක හිමිකරු වන ඔබට පමණක් ලබා දී ඇත.',
                          style: TextStyle(
                            color: AppColors.goldYellow,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Admin Email
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Super Admin Email:',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _adminEmailController,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.shield_rounded,
                        color: AppColors.goldYellow, size: 18),
                    filled: true,
                    fillColor: const Color(0xFF0C2458),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0x6638BDF8)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Secret Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'රහස්‍ය මුරපදය (Secret Password):',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _adminPasswordController,
                  obscureText: _isPasswordObscured,
                  style: const TextStyle(
                    color: AppColors.goldYellow,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key_rounded,
                        color: AppColors.goldYellow, size: 18),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: AppColors.goldYellow,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: const Color(0xFF0C2458),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.goldYellow),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Master Key (PIN)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Master Security Key (PIN):',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _adminKeyController,
                  obscureText: true,
                  style: const TextStyle(
                    color: AppColors.goldYellow,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.pin_rounded,
                        color: AppColors.goldYellow, size: 18),
                    filled: true,
                    fillColor: const Color(0xFF0C2458),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.goldYellow),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Admin Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleAdminLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.goldYellow,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 13),
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
                            'පරිපාලක පුවරුවට පිවිසෙන්න (Enter Super Admin)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                  ),
                ),
              ],

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
