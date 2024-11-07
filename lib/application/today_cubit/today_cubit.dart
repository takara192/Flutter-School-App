import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:school_app/data/model/assignment_model.dart';
import 'package:school_app/data/model/schedule_model.dart';

import '../../data/data_source/assignment_data_source.dart';
import '../../data/data_source/schedule_data_source.dart';

part 'today_state.dart';

class TodayCubit extends Cubit<TodayState> {
  TodayCubit()
      : super(
          TodayState(
            currentDate: DateTime.now(),
          ),
        );

  final scheduleData = ScheduleDataSource();
  final assignmentData = AssignmentDataSource();

  Future fetchSchedules() async {
    emit(state.copyWith(isLoading: true));
    EasyLoading.show(status: 'loading...');

    final schedules = await scheduleData.getScheduleByDate(state.currentDate);
    EasyLoading.dismiss();

    emit(state.copyWith(isLoading: false, schedules: schedules));
    fetchUncompletedAssignmentByWeek(
      state.currentDate.subtract(
        Duration(
          days: state.currentDate.weekday - 1,
        ),
      ),
    );
  }

  Future changeDate(DateTime date) async {
    emit(state.copyWith(currentDate: date));
    await fetchSchedules();
  }

  Future deleteAssignment(int assignmentId) async {
    await assignmentData.deleteAssignment(assignmentId);
    await fetchSchedules();
  }

  Future toggleCompletedAssignment(int assignmentId, bool completed) async {
    await assignmentData.toggleCompletedAssignment(assignmentId, completed);

    await fetchSchedules();
  }

  Future fetchUncompletedAssignmentByWeek(DateTime startDate) async {
    final dates = <DateTime, int>{};

    for (int i = 0; i < 7; i++) {
      final date = startDate.add(Duration(days: i));
      final count = await assignmentData.getUncompletedAssignmentByDate(date);
      DateTime dateOnly = DateTime(date.year, date.month, date.day);
      dates[dateOnly] = count;
    }

    emit(
      state.copyWith(
        dates: {...state.dates, ...dates},
      ),
    );
  }

  Future addNewAssignment({
    required String title,
    required int scheduleId,
    required String details,
    required DateTime dueDate,
    required bool isPriority,
  }) async {
    final assignment = AssignmentModel(
      title: title,
      description: details,
      isCompleted: false,
      dueDate: dueDate,
      scheduleId: scheduleId,
    );

    await assignmentData.addNewAssignment(assignment, isPriority);

    await fetchSchedules();
  }
}
