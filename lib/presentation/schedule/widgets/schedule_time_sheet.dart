import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timetable/flutter_timetable.dart';
import 'package:intl/intl.dart';
import 'package:school_app/data/model/schedule_model.dart';
import 'package:school_app/presentation/schedule/widgets/schedule_cell_builder.dart';
import 'package:school_app/presentation/schedule/widgets/schedule_event_item.dart';
import 'package:school_app/presentation/schedule/widgets/schedule_header_cell_widget.dart';
import 'package:school_app/presentation/schedule/widgets/schedule_hour_label_widget.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';
import '../../../application/schedule_cubit/schedule_cubit.dart';

class ScheduleTimeSheet extends StatelessWidget {
  const ScheduleTimeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    late TimetableController controller;
    return BlocConsumer<ScheduleCubit, ScheduleState>(
      listener: (context, state) {
        if (!state.isLoading) {
          controller = TimetableController(
            cellHeight: 80.h,
            headerHeight: 75.h,
            timelineWidth: 40.w,
            initialColumns: 7,
            start: state.schedules.first.completeStartTime,
            onEvent: (event) {
              if (event is TimetableVisibleDateChanged) {
                context.read<ScheduleCubit>().changeCurrentDate(event.start);
              }
            },
          );
        }
      },
      listenWhen: (previous, current) {
        return previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  15.w.spaceSize,
                  DateFormat.MMMM()
                      .format(state.currentDate)
                      .size24
                      .bold,
                  15.w.spaceSize,
                  IconButton(
                    onPressed: () {
                      controller.dispatch(
                        TimetablePreviousWeek(),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20.sp,
                    ),
                  ),
                  3.w.spaceSize,
                  IconButton(
                    onPressed: () {
                      controller.dispatch(
                        TimetableNextWeek(),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Timetable<ScheduleModel>(
                  controller: controller,
                  cellBuilder: (date) => ScheduleCellBuilder(date: date),
                  hourLabelBuilder: (time) => ScheduleHourLabelWidget(time: time),
                  cornerBuilder: (current) => Container(),
                  headerCellBuilder: (p0) => ScheduleHeaderCellWidget(
                    date: p0,
                  ),
                  nowIndicatorColor: Theme.of(context).colorScheme.error,
                  items: state.schedules
                      .map(
                        (schedule) => TimetableItem<ScheduleModel>(
                          schedule.completeStartTime,
                          schedule.completeEndTime,
                          data: schedule,
                        ),
                      )
                      .toList(),
                  itemBuilder: (p0) => ScheduleEventItem(item: p0),
                  onChangeDate: () {
                    context.read<ScheduleCubit>().changeCurrentDate(
                          controller.visibleDateStart,
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
