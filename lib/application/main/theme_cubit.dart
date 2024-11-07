import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:school_app/utils/helper/shared_preference.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(themeMode: ThemeMode.system));

  void onStart() {
    final bool? themeMode = PreferencesService().getBool(SharedPreferenceKey.keyDarkTheme);

    if(themeMode != null) {
      emit(ThemeInitial(themeMode: themeMode ? ThemeMode.dark : ThemeMode.light));
    }
  }

  void changeTheme(bool isDark) {
    PreferencesService().putBool(SharedPreferenceKey.keyDarkTheme, isDark);
    emit(ThemeInitial(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }

}
