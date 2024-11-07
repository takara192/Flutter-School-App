import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleCellBuilder extends StatelessWidget {
  const ScheduleCellBuilder({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(date, DateTime.now());
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.h,
        ),
        color: isToday ? theme.primaryColor.withOpacity(0.3) : null,
      ),
    );
  }
}
