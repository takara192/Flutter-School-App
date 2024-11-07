import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/presentation/today/widgets/today_schedule.dart';
import '../../../application/today_cubit/today_cubit.dart';

class TodayBody extends StatelessWidget {
  const TodayBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TodayCubit, TodayState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.schedules.length,
            itemBuilder: (context, index) {
              final schedule = state.schedules[index];
              return TodaySchedule(
                schedule: schedule,
                key: ValueKey(schedule.id),
              );
            },
          );

        },
      ),
    );
  }
}
