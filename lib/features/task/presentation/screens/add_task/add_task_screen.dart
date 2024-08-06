import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/common/commons.dart';
import 'package:todo_app/core/widget/custom_elevated_button.dart';
import 'package:todo_app/features/task/cubit/task_cubit.dart';
import 'package:todo_app/features/task/cubit/task_state.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../components/custom_text_form_field.dart';

class AddTaskScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.addTask,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          centerTitle: false,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: BlocProvider.of<TaskCubit>(context).isDark
                  ? AppColors.white
                  : AppColors.background,
              size: 35.h,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocConsumer<TaskCubit, TaskState>(
              listener: (context, state) {
                if (state is InsertTaskSuccessState) {
                  showToast(
                      message: AppStrings.taskAdded,
                      state: ToastStates.success);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                final taskCubit = BlocProvider.of<TaskCubit>(context);
                return Form(
                  key: taskCubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! Title
                      CustomTextFormFieldComponent(
                        text: AppStrings.title,
                        controller: taskCubit.titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.titleError;
                          }
                          return null;
                        },
                        hintText: AppStrings.titleHint,
                        suffixIcon: Icon(
                          Icons.title_outlined,
                          color: BlocProvider.of<TaskCubit>(context).isDark
                              ? AppColors.white
                              : AppColors.background,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      //! Note
                      CustomTextFormFieldComponent(
                        text: AppStrings.note,
                        controller: taskCubit.noteController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.noteError;
                          }
                          return null;
                        },
                        hintText: AppStrings.noteHint,
                        suffixIcon: Icon(
                          Icons.note_alt_outlined,
                          color: BlocProvider.of<TaskCubit>(context).isDark
                              ? AppColors.white
                              : AppColors.background,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      //! Date
                      CustomTextFormFieldComponent(
                        text: AppStrings.date,
                        hintText:
                            DateFormat.yMd().format(taskCubit.currentDate),
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            taskCubit.getDate(context);
                          },
                          icon: Icon(
                            Icons.calendar_month,
                            color: BlocProvider.of<TaskCubit>(context).isDark
                                ? AppColors.white
                                : AppColors.background,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      //! Start - End time
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormFieldComponent(
                              text: AppStrings.startTime,
                              hintText: taskCubit.startTime,
                              readOnly: true,
                              keyboardType: TextInputType.datetime,
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  taskCubit.getStartTime(context);
                                },
                                icon: Icon(
                                  Icons.timer_outlined,
                                  color:
                                      BlocProvider.of<TaskCubit>(context).isDark
                                          ? AppColors.white
                                          : AppColors.background,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 27.w),
                          Expanded(
                            child: CustomTextFormFieldComponent(
                              text: AppStrings.endTime,
                              hintText: taskCubit.endTime,
                              readOnly: true,
                              keyboardType: TextInputType.datetime,
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  taskCubit.getEndTime(context);
                                },
                                icon: Icon(
                                  Icons.timer_outlined,
                                  color:
                                      BlocProvider.of<TaskCubit>(context).isDark
                                          ? AppColors.white
                                          : AppColors.background,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      //! Colors
                      SizedBox(
                          height: 68.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.colors,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              SizedBox(height: 8.h),
                              Expanded(
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          taskCubit.changeCheckMarkIndex(index);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              taskCubit.getColor(index),
                                          radius: 20.r,
                                          child: index == taskCubit.currentIndex
                                              ? const Icon(
                                                  Icons.check,
                                                  color: AppColors.white,
                                                )
                                              : null,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 18.w),
                                    itemCount: 6),
                              ),
                            ],
                          )),

                      state is InsertTaskLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                // strokeWidth: 3,
                              ),
                            )
                          : SizedBox(height: 120.h),
                      //! Cerate Task Button
                      SizedBox(
                        height: 48.h,
                        width: double.infinity,
                        child: CustomElevatedButton(
                            onPressed: () {
                              if (taskCubit.formKey.currentState!.validate()) {
                                taskCubit.insertTask();
                              }
                            },
                            text: AppStrings.createTask),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
