import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:school_app/data/model/class_model.dart';
import 'package:school_app/presentation/add_new_assignment/add_new_assignment_page.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

class SettingClassDialog extends StatefulWidget {
  const SettingClassDialog({super.key, this.classModel});

  final ClassModel? classModel;

  @override
  State<SettingClassDialog> createState() => _SettingClassDialogState();
}

class _SettingClassDialogState extends State<SettingClassDialog> {
  late TextEditingController _classNameController;
  late String? currentColor;

  @override
  void initState() {
    super.initState();
    _classNameController = TextEditingController(text: widget.classModel?.name);
    currentColor = widget.classModel?.color.toHexTriplet;
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text('Edit Class'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _classNameController,
            decoration: const InputDecoration(
              labelText: 'Class Name',
            ),
          ),
          15.h.spaceSize,
          Wrap(
            spacing: 5.w,
            runSpacing: 5.h,
            children: [
              ...classesColor.map(
                (e) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentColor = e;
                      });
                    },
                    borderRadius: BorderRadius.circular(200),
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        color: e.color,
                        shape: BoxShape.circle,
                      ),
                      child: e == currentColor
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if(_classNameController.text.isNotEmpty && currentColor != null) {
              final classModel = widget.classModel == null ? ClassModel(name: _classNameController.text, color: currentColor!.color) : widget.classModel!.copyWith(name: _classNameController.text, color: currentColor!.color);
              Navigator.pop(context,  classModel);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
