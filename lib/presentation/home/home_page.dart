import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/utils/extensions/string_extension.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          bottomNavBarItem(
            icon: 'today',
            context: context,
            label: 'Today',
          ),
          bottomNavBarItem(
            icon: 'week',
            context: context,
            label: 'Schedule',
          ),
          bottomNavBarItem(
            icon: 'checklist',
            context: context,
            label: 'Assignments',
          ),
          bottomNavBarItem(
            icon: 'setting',
            context: context,
            label: 'Settings',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (value) => navigationShell.goBranch(value),
      ),
    );
  }
}

BottomNavigationBarItem bottomNavBarItem({
  required String icon,
  required String label,
  required BuildContext context,
}) {
  final theme = Theme.of(context);

  return BottomNavigationBarItem(
    icon: icon.svgWidget(
      color: theme.colorScheme.onSurface,
      size: 24.sp,
    ),
    activeIcon: icon.svgWidget(
      color: theme.colorScheme.primary,
      size: 24.sp,
    ),
    label: label,
  );
}
