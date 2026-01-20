import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors – Modern Blue
  static const Color primary = Color(0xFF2563EB); // Blue 600
  static const Color primaryLight = Color(0xFF3B82F6); // Blue 500
  static const Color primaryDark = Color(0xFF1E40AF); // Blue 800

  // Secondary Colors – Cool Slate Blue
  static const Color secondary = Color(0xFF475569); // Slate 600
  static const Color secondaryLight = Color(0xFF64748B); // Slate 500
  static const Color secondaryDark = Color(0xFF334155); // Slate 700

  // Neutral Colors (Cool Whites)
  static const Color background = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate 100

  // Border & Divider
  static const Color border = Color(0xFFE2E8F0); // Slate 200
  static const Color borderLight = Color(0xFFF1F5F9);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textTertiary = Color(0xFF94A3B8); // Slate 400

  // Semantic Colors
  static const Color success = Color(0xFF22C55E); // Green 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color info = Color(0xFF38BDF8); // Sky 400

  // Status Colors
  static const Color statusOccupied = Color(0xFF2563EB); // Primary Blue
  static const Color statusVacant = Color(0xFF22C55E);
  static const Color statusMaintenance = Color(0xFFF59E0B);
  static const Color statusReserved = Color(0xFF6366F1); // Indigo 500

  // Overlay & Shadow
  static const Color overlay = Color(0x1A020617); // Subtle cool black
  static const Color shadow = Color(0x0D020617);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [surface, surfaceVariant],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
