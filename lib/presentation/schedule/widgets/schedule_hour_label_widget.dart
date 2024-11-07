import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/utils/extensions/string_extension.dart';

class ScheduleHourLabelWidget extends StatelessWidget {
  const ScheduleHourLabelWidget({super.key, required this.time});

  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey,
            width: 1.h,
          ),
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(top: 1.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          time.hourOfPeriod.toString().length == 1
              ? Text(
            '0${time.hourOfPeriod}',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          )
              : Text(
            time.hourOfPeriod.toString(),
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          (time.period == DayPeriod.am ? 'AM' : 'PM').size12.color(theme.colorScheme.onSurface).w400,
        ],
      ),
    );
  }
}
