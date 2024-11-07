import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:school_app/presentation/today/widgets/today_appbar_header_list.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

import '../../../application/today_cubit/today_cubit.dart';

String _getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return "th";
  }
  switch (day) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}

String formatDateWithSuffix(DateTime date) {
  String formattedDate = DateFormat("MMMM d").format(date);

  String day = DateFormat("d").format(date);
  String suffix = _getDaySuffix(int.parse(day));

  return "$formattedDate$suffix, ${date.year}";
}

class TodayAppBar extends StatelessWidget {
  const TodayAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TodayCubit, TodayState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MediaQuery.of(context).padding.top.spaceSize,
              20.h.spaceSize,
              formatDateWithSuffix(state.currentDate)
                  .size20
                  .w800
                  .color(theme.colorScheme.onSurface),
              20.h.spaceSize,
              const TodayAppbarHeaderList(),
              10.h.spaceSize,
            ],
          ),
        );
      },
    );
  }
}
