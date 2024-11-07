part of 'schedule_cubit.dart';

class ScheduleState extends Equatable {
  const ScheduleState({
    required this.schedules,
    required this.isLoading,
    required this.currentDate,
  });

  final List<ScheduleModel> schedules;
  final bool isLoading;
  final DateTime currentDate;


  @override
  List<Object> get props => [schedules, isLoading, currentDate];

  ScheduleState copyWith({
    List<ScheduleModel>? schedules,
    bool? isLoading,
    DateTime? currentDate,
  }) {
    return ScheduleState(
      schedules: schedules ?? this.schedules,
      isLoading: isLoading ?? this.isLoading,
      currentDate: currentDate ?? this.currentDate,
    );
  }
}

class AddNewScheduleModel{
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final int classId;
  final String room;

  const AddNewScheduleModel({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.classId,
    required this.room,
  });
}