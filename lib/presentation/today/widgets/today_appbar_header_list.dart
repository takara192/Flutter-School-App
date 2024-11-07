import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/presentation/today/widgets/today_appbar_item.dart';

import '../../../application/today_cubit/today_cubit.dart';

class TodayAppbarHeaderList extends StatefulWidget {
  const TodayAppbarHeaderList({super.key});

  @override
  State<TodayAppbarHeaderList> createState() => _TodayAppbarHeaderListState();
}

class _TodayAppbarHeaderListState extends State<TodayAppbarHeaderList> {
  final PageController _pageController = PageController(
    initialPage: 10,
  );

  @override
  initState() {
    super.initState();
    context.read<TodayCubit>().fetchUncompletedAssignmentByWeek(
          getFirstDayOfWeek(10),
        );
  }

  DateTime getFirstDayOfWeek(int pageIndex) {
    final today = DateTime.now();
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    int offsetWeeks = pageIndex - 10;
    return startOfWeek.add(Duration(days: offsetWeeks * 7));
  }

  DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayCubit, TodayState>(
      builder: (context, state) {
        return SizedBox(
          height: 100.h,
          child: PageView.builder(
            itemCount: 21,
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: (value) {
              final date = getFirstDayOfWeek(value);

              if (context.read<TodayCubit>().state.dates[date] == null) {
                context.read<TodayCubit>().fetchUncompletedAssignmentByWeek(date);
              }
            },
            itemBuilder: (context, index) {
              DateTime firstDayOfWeek = getFirstDayOfWeek(index);
              List<DateTime> weekDays = List.generate(
                7,
                (index) => firstDayOfWeek.add(
                  Duration(days: index),
                ),
              );

              return SizedBox(
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: weekDays.map(
                    (date) {
                      return TodayAppbarItem(
                        date: date,
                        isChosen: date.day == state.currentDate.day &&
                            date.month == state.currentDate.month &&
                            date.year == state.currentDate.year,
                        assignmentCount: state.dates[dateOnly(date)] ?? 0,
                        onTap: () {
                          context.read<TodayCubit>().changeDate(date);
                        },
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
