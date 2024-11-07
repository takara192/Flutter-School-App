import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/presentation/common/custom_scaffold.dart';
import 'package:school_app/presentation/schedule/widgets/schedule_add_new.dart';
import 'package:school_app/presentation/schedule/widgets/schedule_time_sheet.dart';

import '../../application/schedule_cubit/schedule_cubit.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Schedule',
      body: const ScheduleTimeSheet(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog<AddNewScheduleModel>(
            context: context,
            builder: (context) {
              return const Dialog.fullscreen(
                child: ScheduleAddNew(),
              );
            },
          ).then(
            (value) {
              if (value != null) {
                context.read<ScheduleCubit>().addSchedule(
                      date: value.date,
                      startTime: value.startTime,
                      endTime: value.endTime,
                      classId: value.classId,
                      room: value.room,
                    );
              }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
