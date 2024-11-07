import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:school_app/data/model/class_model.dart';
import 'package:school_app/presentation/common/custom_check_box.dart';
import 'package:school_app/utils/extensions/string_extension.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';
import '../../data/data_source/class_data_source.dart';

class AddNewAssignmentPage extends StatefulWidget {
  const AddNewAssignmentPage({super.key, this.classModel});

  final ClassModel? classModel;

  @override
  State<AddNewAssignmentPage> createState() => _AddNewAssignmentPageState();
}

class _AddNewAssignmentPageState extends State<AddNewAssignmentPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();


  bool isPriority = false;
  bool isAlertEnabled = true;
  DateTime selectedDate = DateTime.now();
  ClassModel? selectedClass;
  List<ClassModel> classes = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }


  Future<void> _loadData() async {
    if (widget.classModel != null) {
      selectedClass = widget.classModel;
      classes.add(selectedClass!);
    } else {
      classes = await ClassDataSource().getAllClasses();
    }
  }

  String formatDateWithSuffix(DateTime date) {
    String formattedDate = DateFormat("MMMM d").format(date);

    String day = DateFormat("d").format(date);
    String suffix = _getDaySuffix(int.parse(day));

    return "$formattedDate$suffix, ${date.year}";
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "th";
    }
    switch (day) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //App Bar
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                ),
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: MediaQuery.of(context).padding.top + 15.h,
                  bottom: 15.h,
                ),
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop(null);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if(!_formKey.currentState!.validate()) {
                          return;
                        }
                        context.pop({
                          'title': titleController.text,
                          'details': detailsController.text,
                          'isPriority': isPriority,
                          'isAlertEnabled': isAlertEnabled,
                          'dueDate': selectedDate,
                        });
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Body
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      'New assignment',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10.h),
                    //Title
                    'Title'.size14.w700.color(theme.colorScheme.onSurface),
                    SizedBox(height: 5.h),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Eg. Read Book',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 5.h,
                        ),
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20.h),
                    //Class
                    'Class name'.size14.w700.color(theme.colorScheme.onSurface),
                    5.h.spaceSize,
                    TextFormField(
                      initialValue: selectedClass?.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 5.h,
                        ),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                      readOnly: true,
                    ),

                    SizedBox(height: 20.h),

                    //Details
                    'Details'.size14.w700.color(theme.colorScheme.onSurface),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: detailsController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Eg. Read Book from page 100 to 150',
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 5.h,
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    //Checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomCheckbox(
                          value: isPriority,
                          onChanged: (value) {
                            setState(() {
                              isPriority = value;
                            });
                          },
                        ),
                        SizedBox(width: 10.w),
                        'Set as priority'.size14.color(theme.colorScheme.onSurface).w600,
                      ],
                    ),

                    SizedBox(height: 20.h),
                    const Divider(),
                    SizedBox(height: 20.h),
                    //Calendar
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData(useMaterial3: true),
                              child: child ?? const SizedBox(),
                            );
                          },
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: theme.colorScheme.onSurface,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            formatDateWithSuffix(selectedDate),
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
