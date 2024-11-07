import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_app/data/model/assignment_model.dart';
import 'package:school_app/main.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

import '../../../application/today_cubit/today_cubit.dart';

class TodayAssignmentWidget extends StatelessWidget {
  const TodayAssignmentWidget({super.key, required this.assignment, required this.color});

  final AssignmentModel assignment;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Check Box
            GestureDetector(
              onTap: () {
                context.read<TodayCubit>().toggleCompletedAssignment(assignment.id!, !assignment.isCompleted);
              },
              child: Container(
                height: 24.w,
                width: 24.w,
                decoration: BoxDecoration(
                  color: assignment.isCompleted ? color : Colors.transparent,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: assignment.isCompleted
                    ? Icon(Icons.check, size: 16.w, color: Colors.black)
                    : null,
              ),
            ),

            10.w.spaceSize,

            //Title
            SizedBox(
              width: 170.w,
              child: Text(
                assignment.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w600,
                  decoration: assignment.isCompleted ? TextDecoration.lineThrough : null,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            //Delete button
            IconButton(
              icon: Icon(Icons.delete_forever_rounded, color: Colors.blue.shade200),
              onPressed: () {
                context.read<TodayCubit>().deleteAssignment(assignment.id!);
              },
            ),
          ],
        ),
        //description
        Text(
          assignment.description,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w500,
            decoration: assignment.isCompleted ? TextDecoration.lineThrough : null,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),

        3.h.spaceSize,

        Text(
          'Due Date: ${DateFormat('dd/MM/yyyy').format(assignment.dueDate!)}',
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w500,
            decoration: assignment.isCompleted ? TextDecoration.lineThrough : null,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),

      ],
    ).paddingSymmetric(
      vertical: 8.h,
    );
  }
}
