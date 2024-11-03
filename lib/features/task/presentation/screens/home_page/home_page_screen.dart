import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/common/commons.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/features/task/cubit/task_state.dart';

import '../../../../../core/widget/no_task_widget.dart';
import '../../../../../core/widget/task_component.dart';
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
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is UpdateTaskSuccessState) {
                log('UpdateTaskSuccessState');
                showToast(
                    message: AppStrings.taskUpdated,
                    state: ToastStates.success);
              }
              if (state is UpdateTaskErrorState) {
                log('UpdateTaskErrorState');
                showToast(
                    message: AppStrings.taskUpdatedError,
                    state: ToastStates.error);
              }
              if (state is DeleteTaskSuccessState) {
                log('DeleteTaskSuccessState');
                showToast(
                    message: AppStrings.taskDeleted,
                    state: ToastStates.success);
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //! Date

                      Text(DateFormat.yMMMMd().format(DateTime.now()),
                          style: Theme.of(context).textTheme.displayLarge),
                      const Spacer(),

                      //! Theme Icon and Change Theme

                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TaskCubit>(context).changeTheme();
                        },
                        icon: Icon(
                          BlocProvider.of<TaskCubit>(context).isDark
                              ? Icons.light_mode
                              : Icons.dark_mode,
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

                  //! Today

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
                              color: BlocProvider.of<TaskCubit>(context).isDark
                                  ? AppColors.white.withOpacity(0.87)
                                  : AppColors.background,
                            ),
                    dayTextStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: BlocProvider.of<TaskCubit>(context).isDark
                                  ? AppColors.white.withOpacity(0.87)
                                  : AppColors.background,
                            ),
                    monthTextStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: BlocProvider.of<TaskCubit>(context).isDark
                                  ? AppColors.white.withOpacity(0.87)
                                  : AppColors.background,
                            ),
                    onDateChange: (date) {
                      // New date selected
                      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
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
                              return TaskComponent(
                                taskModel: BlocProvider.of<TaskCubit>(context)
                                    .tasksList[index],
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
          child: Icon(
            Icons.add,
            color: AppColors.white,
            size: 32.sp,
          ),
        ),
      ),
    );
  }
}
