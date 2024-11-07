import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/data/model/class_model.dart';
import 'package:school_app/presentation/setting/widgets/setting_class_dialog.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

import '../../../application/settings_cubit/settings_cubit.dart';

class SettingsClassesList extends StatelessWidget {
  const SettingsClassesList({super.key, required this.classes});

  final List<ClassModel> classes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: classes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final theme = Theme.of(context);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: classes[index].color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 40.h,
                  width: 5.w,
                ),
                10.w.spaceSize,
                Text(
                  classes[index].name,
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog<ClassModel>(
                      context: context,
                      builder: (context) {
                        return SettingClassDialog(classModel: classes[index]);
                      },
                    ).then(
                      (value) {
                        if (value != null) {
                          context.read<SettingsCubit>().updateClassSettings(value);
                        }
                      },
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      5.w.spaceSize,
                      Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: theme.colorScheme.onPrimary,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            10.h.spaceSize,
            const Divider(),
          ],
        );
      },
    );
  }
}
