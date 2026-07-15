import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppButtonStyles {
  static final primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.all(18),
    minimumSize: const Size(double.infinity, 52),
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  static final secondary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    minimumSize: const Size(double.infinity, 52),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    side: const BorderSide(color: AppColors.border),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );
}
