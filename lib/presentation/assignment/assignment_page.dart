import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/presentation/assignment/widgets/assignment_list.dart';
import 'package:school_app/presentation/common/custom_scaffold.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

import '../../application/assignments_cubit/assignment_cubit.dart';

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScaffold(
      title: 'Assignments',
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: BlocBuilder<AssignmentCubit, AssignmentState>(
          builder: (context, state) {
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  15.h.spaceSize,
                  //Tab Bar
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15.w,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: TabBar(
                      labelColor: theme.colorScheme.onPrimary,
                      unselectedLabelColor: theme.colorScheme.onSurface,
                      labelStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 16.sp,
                      ),
                      indicator: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(
                          text: 'Due Date',
                        ),
                        Tab(
                          text: 'Priority',
                        ),
                      ],
                    ),
                  ),
                  10.h.spaceSize,
                  const Expanded(
                    child: TabBarView(
                      children: [
                        AssignmentList(
                          index: 0,
                        ),
                        AssignmentList(
                          index: 1,
                        ),
                      ],
                    ),
                  )
                  //list
                  //ClassName
                  //Assignment
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
