import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFieldComponent extends StatelessWidget {
  CustomTextFormFieldComponent({
    super.key,
    required this.hintText,
    this.controller,
    required this.text,
    this.keyboardType,
    this.suffixIcon,
    this.readOnly = false,
    this.validator,
  });
  final String hintText;
  TextEditingController? controller = TextEditingController();
  final String text;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  bool readOnly = false;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(height: 8.h),
        TextFormField(
          style: Theme.of(context).textTheme.displayMedium,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          readOnly: readOnly,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
