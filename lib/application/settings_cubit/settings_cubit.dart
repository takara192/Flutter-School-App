import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_app/data/model/class_model.dart';

import '../../data/data_source/class_data_source.dart';
import '../../utils/helper/shared_preference.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(
      const SettingsState(
        personalName: 'John Doe',
        personalEmail: '',
        classes: [],
      )
  );

  final classDataSource = ClassDataSource();

  void onStart() async {
    String userName = PreferencesService().getString(SharedPreferenceKey.keyUserName) ?? 'John Doe';
    String userEmail = PreferencesService().getString(SharedPreferenceKey.keyUserEmail) ?? 'JohnDoe@email.com';
    final classes = await classDataSource.getAllClasses();

    emit(state.copyWith(personalName: userName, personalEmail: userEmail, classes: classes));
  }

  void updatePersonalSettings(String name, String email) {
    PreferencesService().putString(SharedPreferenceKey.keyUserName, name);
    PreferencesService().putString(SharedPreferenceKey.keyUserEmail, email);

    emit(state.copyWith(personalName: name, personalEmail: email));
  }


  Future updateClassSettings(ClassModel classModel) async {
    await classDataSource.updateClass(classModel);

    emit(state.copyWith(
      classes: state.classes.map((e) => e.id == classModel.id ? classModel : e).toList(),
    ));
  }

  Future addClassSettings(ClassModel classModel) async {
    await classDataSource.insertClass(classModel);

    emit(state.copyWith(
      classes: [...state.classes, classModel],
    ));
  }

}
