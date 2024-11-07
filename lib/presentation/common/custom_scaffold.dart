import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.title, required this.body, this.floatingActionButton});

  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (MediaQuery.of(context).padding.top + 10).h.spaceSize,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: title.size32.color(
              Theme.of(context).colorScheme.onPrimary,
            ).bold,
          ),
          Expanded(
            child: body,
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
