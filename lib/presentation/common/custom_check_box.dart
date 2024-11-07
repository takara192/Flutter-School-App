import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;
  final Color selectedColor;
  final Color unselectedColor;
  final Color checkColor;
  final EdgeInsets padding;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size = 24.0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.checkColor = Colors.white,
    this.padding = const EdgeInsets.all(4.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value); // Toggle the checkbox state
      },
      child: Padding(
        padding: padding,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: value ? selectedColor : Colors.transparent,
            border: Border.all(
              color: value ? selectedColor : unselectedColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: value
              ? Icon(
            Icons.check,
            size: size * 0.7, // Adjust icon size relative to checkbox size
            color: checkColor,
          )
              : null,
        ),
      ),
    );
  }
}
