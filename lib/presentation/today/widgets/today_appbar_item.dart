import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

class TodayAppbarItem extends StatelessWidget {
  const TodayAppbarItem({
    super.key,
    required this.date,
    required this.isChosen,
    required this.assignmentCount,
    required this.onTap,
  });

  final DateTime date;
  final bool isChosen;
  final int assignmentCount;
  final void Function() onTap;

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: isChosen ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: isChosen ? null : isToday(date) ? Border.all(color: theme.colorScheme.primary, width: 2.w) : null
        ),
        height: 95.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DateFormat.d()
                .format(date)
                .size18
                .w800
                .color(theme.colorScheme.onPrimary),
            2.h.spaceSize,
            DateFormat.E()
                .format(date)
                .size10
                .color(theme.colorScheme.onPrimary)
                .weight(isChosen ? FontWeight.bold : FontWeight.normal),
            2.h.spaceSize,
            if (assignmentCount != 0)
              Container(
                  decoration: BoxDecoration(
                      color: theme.colorScheme.error, shape: BoxShape.circle),
                  padding: EdgeInsets.all(6.r),
                  child: Center(
                    child: assignmentCount
                        .toString()
                        .size12
                        .w400
                        .color(theme.colorScheme.onError),
                  ))
          ],
        ),
      ),
    );
  }
}
