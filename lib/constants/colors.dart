import 'package:flutter/material.dart';

/// HIT BAKO Color Palette
/// Extracted precisely from the UI design screenshot.
class AppColors {
  // Main Theme Backgrounds
  static const Color backgroundNavy = Color(0xFF061536);
  static const Color surfaceNavy = Color(0xFF092257);
  static const Color cardNavy = Color(0xFF0C2458);
  static const Color darkDockNavy = Color(0xFF061538);

  // Gradient definitions
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF071C49),
      Color(0xFF0D3888),
      Color(0xFF1557BF),
    ],
  );

  static const LinearGradient promoGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF0D2A6B),
      Color(0xFF113A8F),
      Color(0xFF0D2F78),
    ],
  );

  // Accents
  static const Color cyanAccent = Color(0xFF00C2FF);
  static const Color cyanLight = Color(0xFF38BDF8);
  static const Color goldYellow = Color(0xFFFFC107);
  static const Color brightYellow = Color(0xFFFACC15);
  static const Color notificationRed = Color(0xFFEF4444);

  // Status Badges
  static const Color badgeSale = Color(0xFF2563EB); // For Sale (විකිණීමට)
  static const Color badgeRent = Color(0xFF0284C7); // For Rent (කුලියට)

  // Typography Colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textIceBlue = Color(0xFF93C5FD);
  static const Color textSubtle = Color(0xFF94A3B8);
  static const Color textDark = Color(0xFF0F172A);

  // Borders
  static const Color cardBorder = Color(0x4D38BDF8);
  static const Color dividerColor = Color(0x3338BDF8);
}
