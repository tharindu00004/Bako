enum UserRole {
  member,
  superAdmin,
}

enum VerificationMethod {
  phone,
  email,
}

class AppUser {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final UserRole role;
  final String? district;
  final bool isVerified;
  final VerificationMethod? verifiedVia;
  final DateTime? verifiedAt;

  AppUser({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    required this.role,
    this.district,
    this.isVerified = false,
    this.verifiedVia,
    this.verifiedAt,
  });

  bool get isSuperAdmin => role == UserRole.superAdmin;
  bool get isMember => role == UserRole.member;

  String get displayIdentifier => phone?.isNotEmpty == true ? phone! : (email ?? '');
}
