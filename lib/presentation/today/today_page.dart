import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/presentation/today/widgets/today_app_bar.dart';
import 'package:school_app/presentation/today/widgets/today_body.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TodayAppBar(),
          10.h.spaceSize,
          const TodayBody(),
        ],
      ),
    );
  }
}
