part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.personalName,
    required this.personalEmail,
    required this.classes,
  });

  final String personalName;
  final String personalEmail;
  final List<ClassModel> classes;



  @override
  List<Object> get props => [personalName, personalEmail, classes];

  SettingsState copyWith({
    String? personalName,
    String? personalEmail,
    List<ClassModel>? classes,
  }) {
    return SettingsState(
      personalName: personalName ?? this.personalName,
      personalEmail: personalEmail ?? this.personalEmail,
      classes: classes ?? this.classes,
    );
  }
}

