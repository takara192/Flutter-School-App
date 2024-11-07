import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/utils/extensions/widget_extension.dart';

class SettingEditPersonalDialog extends StatefulWidget {
  const SettingEditPersonalDialog({super.key, required this.name, required this.email});

  final String name;
  final String email;

  @override
  State<SettingEditPersonalDialog> createState() => _SettingEditPersonalDialogState();
}

class _SettingEditPersonalDialogState extends State<SettingEditPersonalDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              6.h.spaceSize,
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              6.h.spaceSize,
              ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()) {
                    Navigator.of(context).pop([_nameController.text, _emailController.text]);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
