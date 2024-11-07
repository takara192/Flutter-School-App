import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/presentation/assignment/widgets/class_and_assignment_container.dart';

import '../../../application/assignments_cubit/assignment_cubit.dart';

class AssignmentList extends StatefulWidget {
  const AssignmentList({super.key, required this.index});

  final int index;

  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  @override
  void initState() {
    super.initState();
    if (widget.index == 0) {
      context.read<AssignmentCubit>().getDueDate();
    } else {
      context.read<AssignmentCubit>().getPriority();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignmentCubit, AssignmentState>(
      builder: (context, state) {
        final classes = state.assignments.keys.toList();
        return ListView.builder(
          itemCount: state.assignments.length,
          itemBuilder: (context, index) {
            return ClassAndAssignmentContainer(
              classModel: classes[index],
              assignments: state.assignments[classes[index]]!,
              index: index,
            );
          },
        );
      },
    );
  }
}
