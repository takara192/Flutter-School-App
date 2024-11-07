import 'package:flutter/material.dart';
import 'package:school_app/presentation/home/home_page.dart';

enum AppRouter{
  homePage,
  todayPage,
  schedulePage,
  assignmentPage,
  settingPage,
  addNewAssignmentPage,
}

class AppRouterConfig{
  static final Map<AppRouter, _CustomRouter> _config = {
    AppRouter.homePage: _CustomRouter(
      name: 'home',
      path: '/',
    ),
    AppRouter.todayPage: _CustomRouter(
      name: 'today',
      path: '/today',
    ),
    AppRouter.schedulePage: _CustomRouter(
      name: 'schedule',
      path: '/schedule',
    ),
    AppRouter.assignmentPage: _CustomRouter(
      name: 'assignment',
      path: '/assignment',
    ),
    AppRouter.settingPage: _CustomRouter(
      name: 'setting',
      path: '/setting',
    ),
    AppRouter.addNewAssignmentPage: _CustomRouter(
      name: 'addNewAssignment',
      path: '/add-new-assignment',
    )
  };


  static String getPath(AppRouter router){
    return _config[router]!.path;
  }

  static String getName(AppRouter router){
    return _config[router]!.name;
  }
}

class _CustomRouter{
  String path;
  String name;

  _CustomRouter({
    required this.path,
    required this.name,
  });
}