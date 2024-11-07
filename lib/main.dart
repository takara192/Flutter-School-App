import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/presentation/common/AppTheme.dart';
import 'package:school_app/router/route.dart';
import 'package:school_app/utils/helper/database_heper.dart';
import 'package:school_app/utils/helper/shared_preference.dart';

import 'application/main/theme_cubit.dart';

void main() async {
  await beforeRunApp();
  runApp(const MyApp());
}

Future beforeRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  PreferencesService.setUpSharedInstance();


  await DatabaseHelper.instance.database;

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(412, 892),
            builder: (_, child) =>
                MaterialApp.router(
                  routerConfig: router,
                  title: 'School App',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: (state as ThemeInitial).themeMode,
                  builder: EasyLoading.init(),
                ),
          );
        },
      ),
    );
  }
}

