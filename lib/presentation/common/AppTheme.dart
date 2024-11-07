import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color_manager.dart';

class AppTheme {
  static final ThemeData lightTheme =  ThemeData.light().copyWith(
    primaryColor: AppColors.actionPrimaryLight,
    scaffoldBackgroundColor: AppColors.backgroundPrimaryLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundSecondaryLight,
      elevation: 1,
      iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimaryLight,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimaryLight, fontSize: 16.sp),
      bodyMedium: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14.sp),
      labelSmall: TextStyle(color: AppColors.textTertiaryLight, fontSize: 12.sp),
    ),
    cardTheme: CardTheme(
      color: AppColors.backgroundSecondaryLight,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundSecondaryLight,
      selectedItemColor: AppColors.actionPrimaryLight,
      unselectedItemColor: AppColors.textSecondaryLight,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontSize: 14.sp,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.actionPrimaryLight,
      secondary: AppColors.purpleLight,
      surface: AppColors.backgroundSecondaryLight,
      onPrimary: AppColors.textPrimaryLight,
      onSecondary: AppColors.textPrimaryLight,
      onSurface: AppColors.textPrimaryLight,
      error: AppColors.errorPrimaryLight,
      onError: AppColors.textPrimaryLight,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontSize: 14.sp,
              color: AppColors.textPrimaryLight,
            ),
          ),
      ),
    ),
    dialogBackgroundColor: AppColors.backgroundSecondaryLight,
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.backgroundSecondaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    ),

  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.actionPrimaryDark,
    scaffoldBackgroundColor: AppColors.backgroundPrimaryDark,
    dialogBackgroundColor: AppColors.backgroundSecondaryDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundSecondaryDark,
      elevation: 1,
      iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimaryDark, fontSize: 16.sp),
      bodyMedium: TextStyle(color: AppColors.textSecondaryDark, fontSize: 14.sp),
      labelSmall: TextStyle(color: AppColors.textTertiaryDark, fontSize: 12.sp),
    ),
    cardTheme: CardTheme(
      color: AppColors.backgroundSecondaryDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.backgroundSecondaryDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14.sp,
            color: AppColors.textPrimaryDark,
          ),
        )
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundSecondaryDark,
      selectedItemColor: AppColors.actionPrimaryDark,
      unselectedItemColor: AppColors.textSecondaryDark,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontSize: 14.sp,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.actionPrimaryDark,
      secondary: AppColors.purpleDark,
      surface: AppColors.backgroundSecondaryDark,
      onPrimary: AppColors.textPrimaryDark,
      onSecondary: AppColors.textPrimaryDark,
      onSurface: AppColors.textSecondaryDark,
      error: AppColors.errorPrimaryDark,
      onError: AppColors.textPrimaryDark,
    ),
  );
}
