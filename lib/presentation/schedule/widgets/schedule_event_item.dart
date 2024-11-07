import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timetable/flutter_timetable.dart';
import 'package:school_app/data/model/schedule_model.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

class ScheduleEventItem extends StatelessWidget {
  const ScheduleEventItem({super.key, required this.item});

  final TimetableItem<ScheduleModel> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 3.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: item.data!.color,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth > 5.w){
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    item.data!.title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                2.h.spaceSize,
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    item.data!.title,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      ),
    );
  }
}
