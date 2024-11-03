import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/widget/custom_elevated_button.dart';

import '../../features/task/cubit/task_cubit.dart';
import '../../features/task/data/model/task_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;
  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.blueGrey;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(24),
              height: 250.h,
              color: AppColors.deepGrey,
              child: Column(
                children: [
                  //! taskCompleted

                  taskModel.isCompleted == 1
                      ? Container()
                      : SizedBox(
                          height: 48.h,
                          width: double.infinity.w,
                          child: CustomElevatedButton(
                            text: AppStrings.taskCompleted,
                            onPressed: () {
                              BlocProvider.of<TaskCubit>(context)
                                  .updateTask(taskModel.id);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                  SizedBox(
                    height: 24.h,
                  ),

                  //! deleteTask

                  SizedBox(
                    height: 48.h,
                    width: double.infinity.w,
                    child: CustomElevatedButton(
                      text: AppStrings.deleteTask,
                      color: AppColors.red,
                      onPressed: () {
                        BlocProvider.of<TaskCubit>(context)
                            .deleteTask(taskModel.id);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //cancel
                  SizedBox(
                    height: 48.h,
                    width: double.infinity.w,
                    child: CustomElevatedButton(
                      text: AppStrings.cancel,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      child: Container(
        height: 143.h,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: getColor(taskModel.color),
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            //column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! title

                  Text(
                    taskModel.title,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: BlocProvider.of<TaskCubit>(context).isDark
                            ? AppColors.white
                            : AppColors.white,
                        fontSize: 26.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  //! startTime - endTime

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.timer_sharp,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${taskModel.startTime} - ${taskModel.endTime}',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                              color: BlocProvider.of<TaskCubit>(context).isDark
                                  ? AppColors.white
                                  : AppColors.white,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  //! note

                  Text(
                    taskModel.note,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: BlocProvider.of<TaskCubit>(context).isDark
                            ? AppColors.white
                            : AppColors.white,
                        fontSize: 24.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            //! divider

            Container(
              height: 75.h,
              width: 1.w,
              color: Colors.white,
              margin: const EdgeInsets.only(right: 10),
            ),

            //text
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                taskModel.isCompleted == 1
                    ? AppStrings.complete
                    : AppStrings.todo,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: BlocProvider.of<TaskCubit>(context).isDark
                          ? AppColors.white
                          : AppColors.white,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
