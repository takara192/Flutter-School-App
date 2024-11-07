part of 'assignment_cubit.dart';

class AssignmentState extends Equatable {
  const AssignmentState(this.assignments);

  final Map<ClassModel, List<AssignmentModel>> assignments;

  @override
  List<Object> get props => [assignments];
}
