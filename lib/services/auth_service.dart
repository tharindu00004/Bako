import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../constants/admin_credentials.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // Stored mock verified members database in-memory
  final Map<String, Map<String, dynamic>> _registeredMembers = {
    '0771234567': {
      'name': 'කසුන් පෙරේරා (Kasun Perera)',
      'phone': '077 123 4567',
      'email': 'kasun@gmail.com',
      'password': 'password123',
      'isVerified': true,
      'district': 'කුරුණෑගල',
    },
    'kasun@gmail.com': {
      'name': 'කසුන් පෙරේරා (Kasun Perera)',
      'phone': '077 123 4567',
      'email': 'kasun@gmail.com',
      'password': 'password123',
      'isVerified': true,
      'district': 'කුරුණෑගල',
    },
  };

  /// Normalizes phone number or email for lookups
  String _normalizeIdentifier(String input) {
    return input.replaceAll(' ', '').trim().toLowerCase();
  }

  /// Send 6-digit OTP Verification code to Phone or Email
  Future<String> sendVerificationCode(String phoneOrEmail, VerificationMethod method) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Default simulated OTP code for testing
    const String demoOtp = '739281';
    return demoOtp;
  }

  /// Verify OTP and Register New Member
  Future<bool> verifyAndRegisterMember({
    required String name,
    required String identifier,
    required String password,
    required String otpCode,
    required VerificationMethod method,
    String? district,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Validates 6-digit OTP code (accepts 739281 or any valid 6-digit code)
    if (otpCode.trim().length != 6) {
      return false;
    }

    final key = _normalizeIdentifier(identifier);
    final isEmail = method == VerificationMethod.email;

    _registeredMembers[key] = {
      'name': name,
      'phone': isEmail ? null : identifier,
      'email': isEmail ? identifier : null,
      'password': password,
      'isVerified': true,
      'district': district ?? 'කුරුණෑගල',
    };

    _currentUser = AppUser(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      phone: isEmail ? null : identifier,
      email: isEmail ? identifier : null,
      role: UserRole.member,
      district: district ?? 'කුරුණෑගල',
      isVerified: true,
      verifiedVia: method,
      verifiedAt: DateTime.now(),
    );

    notifyListeners();
    return true;
  }

  /// Member Login using either Phone Number OR Email + Password
  Future<Map<String, dynamic>> loginMember({
    required String phoneOrEmail,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final cleanId = _normalizeIdentifier(phoneOrEmail);
    final memberData = _registeredMembers[cleanId];

    if (memberData == null) {
      return {
        'success': false,
        'message': 'මෙම ගිණුම සොයාගත නොහැක. කරුණාකර පළමුව ලියාපදිංචි වී තහවුරු කරන්න. (Account not found. Please register & verify first)',
        'needsVerification': true,
      };
    }

    if (memberData['password'] != password) {
      return {
        'success': false,
        'message': 'වැරදි මුරපදයකි! කරුණාකර නැවත උත්සාහ කරන්න. (Incorrect password)',
        'needsVerification': false,
      };
    }

    if (memberData['isVerified'] != true) {
      return {
        'success': false,
        'message': 'ඔබගේ ගිණුම තවමත් තහවුරු කර නොමැත. OTP කේතයෙන් තහවුරු කරන්න. (Account not verified yet)',
        'needsVerification': true,
      };
    }

    _currentUser = AppUser(
      id: 'usr_mem_001',
      name: memberData['name'] ?? 'සාමාජික පරිශීලක',
      phone: memberData['phone'],
      email: memberData['email'],
      role: UserRole.member,
      district: memberData['district'] ?? 'කුරුණෑගල',
      isVerified: true,
    );

    notifyListeners();
    return {
      'success': true,
      'message': 'සාර්ථකව ඇතුල් විය!',
    };
  }

  /// Super Admin Exclusive Login (Only known by the owner)
  Future<Map<String, dynamic>> loginSuperAdmin({
    required String email,
    required String password,
    required String masterSecurityKey,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final bool isValid = AdminCredentials.verify(
      inputEmail: email,
      inputPassword: password,
      inputSecurityKey: masterSecurityKey,
    );

    if (!isValid) {
      return {
        'success': false,
        'message': '❌ අවසර නැත! රහස්‍ය මුරපදය හෝ Master Key එක වැරදියි. (Invalid Super Admin credentials)',
      };
    }

    _currentUser = AppUser(
      id: 'super_admin_master',
      name: 'ප්‍රධාන පරිපාලක (Super Admin)',
      email: AdminCredentials.email,
      role: UserRole.superAdmin,
      isVerified: true,
      verifiedVia: VerificationMethod.email,
      verifiedAt: DateTime.now(),
    );

    notifyListeners();
    return {
      'success': true,
      'message': 'සාදරයෙන් පිළිගනිමු, Super Admin! 👑',
    };
  }

  /// Logout
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
