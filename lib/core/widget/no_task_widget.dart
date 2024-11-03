//! No Task Widget
  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_assets.dart';
import '../utils/app_strings.dart';

Center noTasksWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(AppAssets.noTask, width: 277.w, height: 277.h),
          SizedBox(
            height: 10.h,
          ),
          Text(
            AppStrings.noTaskTitle,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            AppStrings.noTaskSubTitle,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
