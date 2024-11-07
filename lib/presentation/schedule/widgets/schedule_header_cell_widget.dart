import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:school_app/presentation/add_new_assignment/add_new_assignment_page.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

class ScheduleHeaderCellWidget extends StatelessWidget {
  const ScheduleHeaderCellWidget({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(date, DateTime.now());
    final theme = Theme.of(context);
    return Container(
      decoration: isToday ? BoxDecoration(
        color: theme.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.r),
          topRight: Radius.circular(10.r),
        ),
      ) : null,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            date.day.toString().size20.color(theme.colorScheme.onSurface).bold,
            3.h.spaceSize,
            DateFormat.E().format(date).size14.color(theme.colorScheme.onSurface).w400,
          ],
        ),
      ),
    );
  }
}
