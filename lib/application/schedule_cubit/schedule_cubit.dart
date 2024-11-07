import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_app/data/model/schedule_model.dart';

import '../../data/data_source/schedule_data_source.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final scheduleDataSource = ScheduleDataSource();

  ScheduleCubit()
      : super(
          ScheduleState(
            schedules: const [],
            isLoading: true,
            currentDate: DateTime.now(),
          ),
        );

  Future onStart() async {
    final schedules = await scheduleDataSource.getSchedules();
    emit(state.copyWith(schedules: schedules, isLoading: false));
  }

  Future addSchedule({
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    required int classId,
    required String room,
  }) async {
    await scheduleDataSource.addNewSchedule(
      date: date,
      startTime: startTime,
      endTime: endTime,
      classId: classId,
      room: room,
    );
    onStart();
  }

  void changeCurrentDate(DateTime date) {
    emit(state.copyWith(currentDate: date));
  }
}
