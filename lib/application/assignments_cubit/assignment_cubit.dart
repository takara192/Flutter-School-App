import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_app/data/model/assignment_model.dart';
import 'package:school_app/data/model/class_model.dart';
import '../../data/data_source/assignment_data_source.dart';

part 'assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit() : super(const AssignmentState({}));

  final _dataSource = AssignmentDataSource();

  Future getDueDate() async {
    final result = await _dataSource.fetchDueDateAssignment();
    emit(AssignmentState(result));
  }

  Future getPriority() async {
    final result = await _dataSource.fetchPriorityAssignment();
    emit(AssignmentState(result));
  }

  Future toggleCompletedAssignment(int assignmentId, bool completed, int index) async {
    await _dataSource.toggleCompletedAssignment(assignmentId, completed);
    if(index == 1) {
      await getDueDate();
    } else {
      await getPriority();
    }
  }

}
