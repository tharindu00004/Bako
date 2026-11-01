/// ==============================================================
/// 🔒 SUPER ADMIN PRIVATE CREDENTIALS
/// ==============================================================
/// IMPORTANT: Only you (the owner/super admin) should know these credentials!
/// You can modify the email, password, and security master key below anytime.
class AdminCredentials {
  /// Super Admin Login Email
  static const String email = 'admin@hitbako.lk';

  /// 🔑 Super Admin Secret Password (Generated exclusively for you)
  /// You can change this to any password you prefer.
  static const String password = 'HitBako#SuperAdmin@2026!';

  /// 🛡️ Super Admin Master Security PIN / Key
  static const String securityMasterKey = '882199';

  /// Verification check helper
  static bool verify({
    required String inputEmail,
    required String inputPassword,
    required String inputSecurityKey,
  }) {
    final bool isEmailMatch = inputEmail.trim().toLowerCase() == email.toLowerCase();
    final bool isPasswordMatch = inputPassword.trim() == password;
    final bool isKeyMatch = inputSecurityKey.trim() == securityMasterKey;

    return isEmailMatch && isPasswordMatch && isKeyMatch;
  }
}
