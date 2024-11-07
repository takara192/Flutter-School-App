import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/application/main/theme_cubit.dart';
import 'package:school_app/data/model/schedule_model.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

class SettingDarkModeWidget extends StatelessWidget {
  const SettingDarkModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Row(
          children: [
            Switch(
              value: (state as ThemeInitial).themeMode == ThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeCubit>().changeTheme(value);
              },
            ),
            10.w.spaceSize,
            'Dark Mode'.size14.w700.color(Theme.of(context).colorScheme.onPrimary),
          ],
        );
      },
    );
  }
}
