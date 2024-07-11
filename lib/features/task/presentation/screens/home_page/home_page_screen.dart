import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/common/commons.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/core/widget/custom_elevated_button.dart';
import 'package:todo_app/features/task/cubit/task_state.dart';
import 'package:todo_app/features/task/data/model/task_model.dart';

import '../../../cubit/task_cubit.dart';
import '../add_task/add_task_screen.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(DateFormat.yMMMMd().format(DateTime.now()),
                          style: Theme.of(context).textTheme.displayLarge),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TaskCubit>(context).changeTheme();
                        },
                        icon: Icon(
                          Icons.mode_night,
                          color: BlocProvider.of<TaskCubit>(context).isDark
                              ? AppColors.white
                              : AppColors.background,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(AppStrings.today,
                      style: Theme.of(context).textTheme.displayLarge),
                  SizedBox(
                    height: 8.h,
                  ),
                  DatePicker(
                    DateTime.now(),
                    width: 62.w,
                    height: 94.h,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primary,
                    selectedTextColor: AppColors.white,
                    dateTextStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: AppColors.white.withOpacity(0.87),
                            ),
                    dayTextStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: AppColors.white.withOpacity(0.87),
                            ),
                    monthTextStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: AppColors.white.withOpacity(0.87),
                            ),
                    onDateChange: (date) {
                      // New date selected
                      log(date.toString());
                    },
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  BlocProvider.of<TaskCubit>(context).tasksList.isEmpty
                      ? noTasksWidget(context)
                      : Expanded(
                          child: ListView.builder(
                            itemCount: BlocProvider.of<TaskCubit>(context)
                                .tasksList
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 240.h,
                                        width: double.infinity.w,
                                        padding: const EdgeInsets.all(24),
                                        color: AppColors.deepGrey,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 48.h,
                                              width: double.infinity.w,
                                              child: CustomElevatedButton(
                                                  color: AppColors.primary,
                                                  onPressed: () {},
                                                  text:
                                                      AppStrings.taskCompleted),
                                            ),
                                            SizedBox(
                                              height: 24.h,
                                            ),
                                            SizedBox(
                                              height: 48.h,
                                              width: double.infinity.w,
                                              child: CustomElevatedButton(
                                                  color: AppColors.red,
                                                  onPressed: () {},
                                                  text: AppStrings.deleteTask),
                                            ),
                                            SizedBox(
                                              height: 24.h,
                                            ),
                                            SizedBox(
                                              height: 48.h,
                                              width: double.infinity.w,
                                              child: CustomElevatedButton(
                                                  color: AppColors.primary,
                                                  onPressed: () {},
                                                  text: AppStrings.cancel),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: TaskComponent(
                                  taskModel: BlocProvider.of<TaskCubit>(context)
                                      .tasksList[index],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate(context: context, screen: AddTaskScreen());
          },
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: AppColors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

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
}

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
              height: 240,
              color: AppColors.deepGrey,
              child: Column(
                children: [
                  //taskCompleted
                  taskModel.isCompleted == 1
                      ? Container()
                      : SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: CustomElevatedButton(
                            text: AppStrings.taskCompleted,
                            onPressed: () {
                              BlocProvider.of<TaskCubit>(context)
                                  .updateTask(taskModel.id);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 24,
                  ),

                  //deleteTask
                  SizedBox(
                    height: 48,
                    width: double.infinity,
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
                  const SizedBox(
                    height: 24,
                  ),
                  //cancel
                  SizedBox(
                    height: 48,
                    width: double.infinity,
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
        height: 140,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: getColor(taskModel.color),
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            //column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text(
                    taskModel.title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),

                  //row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.timer,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${taskModel.startTime} - ${taskModel.endTime}',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  //note
                  Text(
                    taskModel.note,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
            ),

            //divider
            Container(
              height: 75,
              width: 1,
              color: Colors.white,
              margin: const EdgeInsets.only(right: 10),
            ),
            // const SizedBox(width: 10,),
            //text
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                taskModel.isCompleted == 1
                    ? AppStrings.complete
                    : AppStrings.todo,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}