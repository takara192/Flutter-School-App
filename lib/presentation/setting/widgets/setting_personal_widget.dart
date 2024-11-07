import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/presentation/add_new_assignment/add_new_assignment_page.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

import '../../../application/settings_cubit/settings_cubit.dart';

class SettingPersonalWidget extends StatelessWidget {
  const SettingPersonalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getListTitle(
              Icons.person,
              state.personalName,
            ),
            3.h.spaceSize,
            const Divider(),
            3.h.spaceSize,
            getListTitle(
              Icons.email,
              state.personalEmail,
            ),
          ],
        );
      },
    );
  }
}

Widget getListTitle(IconData icon,
    String title,) {
  return Row(
    children: [
      Icon(
        icon,
        size: 30.sp,
      ),
      SizedBox(width: 15.w),
      Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
