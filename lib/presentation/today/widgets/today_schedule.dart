import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:school_app/application/today_cubit/today_cubit.dart';
import 'package:school_app/data/model/class_model.dart';
import 'package:school_app/data/model/schedule_model.dart';
import 'package:school_app/presentation/today/widgets/today_assignment_widget.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

import '../../../router/route_config.dart';

class TodaySchedule extends StatefulWidget {
  const TodaySchedule({super.key, required this.schedule});

  final ScheduleModel schedule;



  @override
  State<TodaySchedule> createState() => _TodayScheduleState();
}

class _TodayScheduleState extends State<TodaySchedule> {
  bool isOpened = false;

  int countAssignments() {
    int numberOfAssignments = 0;
    for (var element in widget.schedule.assignments) {
      if (!element.isCompleted) {
        numberOfAssignments++;
      }
    }
    return numberOfAssignments;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        setState(() {
          isOpened = !isOpened;
        });
      },
      borderRadius: BorderRadius.all(
        Radius.circular(12.r),
      ),
      child: AnimatedContainer(
        duration: Durations.short1,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 16.h,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 16.w,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Icon
              Icon(
                isOpened
                    ? Icons.keyboard_arrow_down_sharp
                    : Icons.keyboard_arrow_right_sharp,
                size: 24.r,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              4.w.spaceSize,
              //Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateFormat('hh:mm a')
                      .format(widget.schedule.startTime)
                      .toString()
                      .size12
                      .color(Theme.of(context).colorScheme.onSurface)
                      .w400,
                  DateFormat('hh:mm a')
                      .format(widget.schedule.endTime)
                      .toString()
                      .size12
                      .color(Theme.of(context).colorScheme.onSurface)
                      .w400,
                ],
              ),
              //Divider
              VerticalDivider(
                color: widget.schedule.color,
                thickness: 1.w,
                width: 16.w,
              ),
              //Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Title
                    widget.schedule.title.size14
                        .color(widget.schedule.color)
                        .w700,
                    5.h.spaceSize,
                    //Description
                    SizedBox(
                      height: 20.h,
                      child: Row(
                        children: [
                          widget.schedule.room.size12
                              .color(Theme.of(context).colorScheme.onSurface)
                              .w400,
                          if (countAssignments() != 0 && !isOpened)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.5),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                  ),
                                  width: 1.w,
                                  height: double.infinity,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 14.w,
                                  height: 14.w,
                                  child: Center(
                                    child: countAssignments()
                                        .toString()
                                        .size10
                                        .black
                                        .w400,
                                  ),
                                ),
                                4.w.spaceSize,
                                'Missing assignment'.size12.w400.color(
                                    Theme.of(context).colorScheme.onSurface),
                              ],
                            ),
                        ],
                      ),
                    ),
                    5.h.spaceSize,
                    //Assignments
                    if (widget.schedule.assignments.isNotEmpty && isOpened)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Assignment
                          Row(
                            children: [
                              'Assignments'.size14.w700.color(
                                    Theme.of(context).colorScheme.onSurface,
                                  ),
                              4.w.spaceSize,
                              if (countAssignments() != 0)
                                Container(
                                  width: 18.w,
                                  height: 18.w,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: countAssignments()
                                      .toString()
                                      .size12
                                      .w600
                                      .color(
                                        Colors.white,
                                      ),
                                )
                            ],
                          ),
                          4.h.spaceSize,
                          ...widget.schedule.assignments.map(
                            (e) {
                              return TodayAssignmentWidget(
                                assignment: e,
                                color: widget.schedule.color,
                              );
                            },
                          ),
                          10.h.spaceSize,
                          ElevatedButton(
                            onPressed: () async {
                              final result = await context.pushNamed(
                                AppRouterConfig.getName(
                                    AppRouter.addNewAssignmentPage),
                                extra: ClassModel(
                                  name: widget.schedule.title,
                                  room: widget.schedule.room,
                                  color: widget.schedule.color,
                                  id: widget.schedule.classId,
                                ),
                              );

                              if (result != null && mounted) {
                                result as Map<String, dynamic>;
                                context.read<TodayCubit>().addNewAssignment(
                                      title: result['title'],
                                      scheduleId: widget.schedule.id,
                                      details: result['details'],
                                      dueDate: result['dueDate'],
                                      isPriority: result['isPriority'],
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              // Border
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: "+ Assignment".size12.bold.color(
                                  theme.colorScheme.onPrimary,
                                ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
