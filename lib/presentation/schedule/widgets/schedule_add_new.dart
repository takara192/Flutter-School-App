import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:school_app/data/data_source/class_data_source.dart';
import 'package:school_app/data/model/class_model.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

import '../../../application/schedule_cubit/schedule_cubit.dart';

class ScheduleAddNew extends StatefulWidget {
  const ScheduleAddNew({super.key});

  @override
  State<ScheduleAddNew> createState() => _ScheduleAddNewState();
}

class _ScheduleAddNewState extends State<ScheduleAddNew> {
  final formKey = GlobalKey<FormState>();
  final classController = TextEditingController();
  final roomController = TextEditingController();
  final dateController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  int? selectedClass;
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  bool isBefore(TimeOfDay a, TimeOfDay b) {
    if (a.hour < b.hour) {
      return true;
    } else if (a.hour == b.hour && a.minute < b.minute) {
      return true;
    }
    return false;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat("dd/MM/yyyy").format(picked);
      });
    }
  }

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (startTime ?? TimeOfDay.now())
          : (endTime ?? TimeOfDay.now()),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          if (endTime != null && isBefore(picked, endTime!)) {
            endTime = null;
          }
          startController.text = picked.format(context);
          startTime = picked;
        } else {
          if (startTime != null && isBefore(startTime!, picked)) {
            endController.text = picked.format(context);
            endTime = picked;
          }
        }
      });
    }
  }

  Future<List<ClassModel>> fetchClass() async {
    final classDataSource = ClassDataSource();
    return await classDataSource.getAllClasses();
  }

  Future selectClass(BuildContext context) async {
    return await showModalBottomSheet<ClassModel>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return FutureBuilder(
          future: fetchClass(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final List<ClassModel> classes = snapshot.data as List<ClassModel>;
            return ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final ClassModel classModel = classes[index];
                return ListTile(
                  title: Text(classModel.name),
                  onTap: () {
                    Navigator.of(context).pop(classModel);
                  },
                );
              },
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedClass = value.id;
          classController.text = value.name;
        });
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.h.spaceSize,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 20.sp,
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final now = DateTime.now();
                        Navigator.of(context).pop(
                            AddNewScheduleModel(
                              classId: selectedClass!,
                              date: selectedDate!,
                              startTime: DateTime(
                                now.year,
                                now.month,
                                now.day,
                                startTime!.hour,
                                startTime!.minute,
                              ),
                              endTime: DateTime(
                                now.year,
                                now.month,
                                now.day,
                                endTime!.hour,
                                endTime!.minute,
                              ),
                              room: roomController.text,
                            )
                        );
                      }
                    },
                    child: 'Save'.size14,
                  ),
                ],
              ),
              15.h.spaceSize,
              'Class Name'
                  .size14
                  .color(colorScheme.onSurface.withAlpha(125))
                  .w400,
              5.h.spaceSize,
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Class',
                  hintText: 'Eg. Class A',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 5.h,
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
                controller: classController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select class';
                  }
                  return null;
                },
                onTap: () => selectClass(context),
                readOnly: true,
              ),
              15.h.spaceSize,
              'Room'.size14.color(colorScheme.onSurface.withAlpha(125)).w400,
              5.h.spaceSize,
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Room',
                  hintText: 'Eg. 303',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 5.h,
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
                controller: roomController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter class';
                  }
                  return null;
                },
              ),
              15.h.spaceSize,
              'Date'.size14.color(colorScheme.onSurface.withAlpha(125)).w400,
              10.h.spaceSize,
              SizedBox(
                width: 200.w,
                child: TextFormField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 5.h,
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select date';
                    }
                    return null;
                  },
                  onTap: () => selectDate(context),
                ),
              ),
              15.h.spaceSize,
              'Time'.size14.color(colorScheme.onSurface.withAlpha(125)).w400,
              10.h.spaceSize,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: TextFormField(
                      controller: startController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.onSurface),
                        ),
                        suffixIcon: Icon(Icons.access_time, color: colorScheme.onSurface),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 5.h,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        labelStyle: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 14.sp,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select start time';
                        }
                        return null;
                      },
                      onTap: () => selectTime(context, true),
                    ),
                  ),
                  8.w.spaceSize,
                  Container(
                    height: 2.h,
                    width: 12.w,
                    color: colorScheme.onSurface,
                  ),
                  8.w.spaceSize,
                  SizedBox(
                    width: 150.w,
                    child: TextFormField(
                      controller: endController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.onSurface),
                        ),
                        suffixIcon: Icon(Icons.access_time, color: colorScheme.onSurface),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 5.h,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        labelStyle: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 14.sp,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select end time';
                        }
                        return null;
                      },
                      onTap: () => selectTime(context, false),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
