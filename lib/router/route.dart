import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/application/schedule_cubit/schedule_cubit.dart';
import 'package:school_app/application/settings_cubit/settings_cubit.dart';
import 'package:school_app/application/today_cubit/today_cubit.dart';
import 'package:school_app/presentation/add_new_assignment/add_new_assignment_page.dart';
import 'package:school_app/presentation/assignment/assignment_page.dart';
import 'package:school_app/presentation/schedule/schedule_page.dart';
import 'package:school_app/presentation/setting/setting_page.dart';
import 'package:school_app/presentation/today/today_page.dart';
import 'package:school_app/router/route_config.dart';

import '../application/assignments_cubit/assignment_cubit.dart';
import '../data/model/class_model.dart';
import '../presentation/home/home_page.dart';

final router = GoRouter(
  initialLocation: AppRouterConfig.getPath(AppRouter.todayPage),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouterConfig.getPath(AppRouter.todayPage),
              name: AppRouterConfig.getName(AppRouter.todayPage),
              builder: (context, state) {
                return BlocProvider(
                  create: (context) =>
                  TodayCubit()
                    ..fetchSchedules(),
                  child: const TodayPage(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouterConfig.getPath(AppRouter.schedulePage),
              name: AppRouterConfig.getName(AppRouter.schedulePage),
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => ScheduleCubit()..onStart(),
                  child: const SchedulePage(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouterConfig.getPath(AppRouter.assignmentPage),
              name: AppRouterConfig.getName(AppRouter.assignmentPage),
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => AssignmentCubit(),
                  child: const AssignmentPage(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouterConfig.getPath(AppRouter.settingPage),
              name: AppRouterConfig.getName(AppRouter.settingPage),
              builder: (context, state) {
                return BlocProvider(
                  create: (context) =>
                  SettingsCubit()
                    ..onStart(),
                  child: const SettingPage(),
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRouterConfig.getPath(AppRouter.addNewAssignmentPage),
      name: AppRouterConfig.getName(AppRouter.addNewAssignmentPage),
      builder: (context, state) {
        final classModel = state.extra as ClassModel?;
        return AddNewAssignmentPage(
          classModel: classModel,
        );
      },
    ),
  ],
);
