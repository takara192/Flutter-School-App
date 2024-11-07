import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/data/model/class_model.dart';
import 'package:school_app/presentation/setting/widgets/setting_class_dialog.dart';
import 'package:school_app/presentation/setting/widgets/setting_dark_mode_widget.dart';
import 'package:school_app/presentation/setting/widgets/setting_edit_personal_dialog.dart';
import 'package:school_app/presentation/setting/widgets/setting_personal_widget.dart';
import 'package:school_app/presentation/setting/widgets/settings_classes_list.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

import '../../application/settings_cubit/settings_cubit.dart';
import '../common/custom_scaffold.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Settings',
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //App Settings
                  10.h.spaceSize,
                  'App Settings'.title(context),
                  6.h.spaceSize,
                  const Divider(),
                  6.h.spaceSize,
                  const SettingDarkModeWidget(),
                  //Personal Settings
                  10.h.spaceSize,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Personal settings'.title(context),
                      IconButton(
                        onPressed: () async {
                          showDialog<List<String>>(
                            context: context,
                            builder: (context) {
                              return SettingEditPersonalDialog(
                                name: state.personalName,
                                email: state.personalEmail,
                              );
                            },
                          ).then(
                            (value) {
                              if (value != null) {
                                context
                                    .read<SettingsCubit>()
                                    .updatePersonalSettings(value[0], value[1]);
                              }
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  6.h.spaceSize,
                  const SettingPersonalWidget(),
                  //Classes settings
                  6.h.spaceSize,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Classes settings'.title(context),
                      IconButton(
                        onPressed: () async {
                          showDialog<ClassModel?>(
                            context: context,
                            builder: (context) {
                              return const SettingClassDialog();
                            },
                          ).then(
                            (value) {
                              if (value != null) {
                                context.read<SettingsCubit>().addClassSettings(value);
                              }
                            },
                          );
                        },
                        icon: const Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                  6.h.spaceSize,
                  SettingsClassesList(
                    classes: state.classes,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

extension TextX on String {
  Text title(BuildContext context) => Text(
        this,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
}
