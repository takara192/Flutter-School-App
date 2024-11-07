import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/data/model/assignment_model.dart';
import 'package:school_app/data/model/class_model.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

import '../../../application/assignments_cubit/assignment_cubit.dart';

class ClassAndAssignmentContainer extends StatelessWidget {
  const ClassAndAssignmentContainer({
    super.key,
    required this.classModel,
    required this.assignments,
    required this.index,
  });

  final ClassModel classModel;
  final List<AssignmentModel> assignments;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        classModel.name.size16.bold.color(classModel.color),
        8.h.spaceSize,
        ...assignments.map(
          (assignment) {
            return ChecklistItem(
              title: assignment.title,
              note: assignment.description,
              isCompleted: assignment.isCompleted,
              color: classModel.color,
              index: index,
              assignmentId: assignment.id!,
            );
          },
        ),
      ],
    );
  }
}

class ChecklistItem extends StatelessWidget {
  final String title;
  final String note;
  final bool isCompleted;
  final Color color;
  final int index;
  final int assignmentId;

  const ChecklistItem({
    super.key,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.color,
    required this.index,
    required this.assignmentId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox
          Checkbox(
            value: isCompleted,
            onChanged: (bool? value) {
              context
                  .read<AssignmentCubit>()
                  .toggleCompletedAssignment(assignmentId, value!, index);
            },
            activeColor: color,
          ),
          SizedBox(width: 8.w),
          // Texts with title and note
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                note,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(90),
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
