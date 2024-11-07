part of 'today_cubit.dart';

class TodayState extends Equatable {
  const TodayState({
    this.isLoading = false,
    this.schedules = const [],
    required this.currentDate,
    this.dates = const {},
  });

  final bool isLoading;
  final List<ScheduleModel> schedules;
  final DateTime currentDate;
  final Map<DateTime, int> dates;

  @override
  List<Object> get props => [isLoading, schedules, currentDate, dates];

  TodayState copyWith({
    bool? isLoading,
    List<ScheduleModel>? schedules,
    DateTime? currentDate,
    Map<DateTime, int>? dates,
  }) {
    return TodayState(
      isLoading: isLoading ?? this.isLoading,
      schedules: schedules ?? this.schedules,
      currentDate: currentDate ?? this.currentDate,
      dates: dates ?? this.dates,
    );
  }
}
