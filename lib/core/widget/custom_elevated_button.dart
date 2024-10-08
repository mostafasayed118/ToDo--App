import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.onPressed, required this.text, this.color});
  final VoidCallback onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          backgroundColor: WidgetStateProperty.all(color),
          textStyle: WidgetStateProperty.all(
              Theme.of(context).textTheme.displayMedium)),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: AppColors.white,
            ),
      ),
    );
  }
}
