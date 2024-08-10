import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/task/cubit/task_state.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../core/database/cache/cache_helper.dart';
import '../../../core/database/sqflite_helper/sqflite_helper.dart';
import '../../../core/services/service.locator.dart';
import '../data/model/task_model.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 45)));
  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //!get Date From User
  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      // initialDatePickerMode: DatePickerMode.day,
      // initialEntryMode: DatePickerEntryMode.inputOnly,
    );

    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(GetDateSuccessState());
    } else {
      log('pickedDate == null');
      emit(GetDateErrorState());
    }
  }

  late TimeOfDay scheduledTime;
  //! get StartTime From User
  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());

    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      scheduledTime = pickedStartTime;
      emit(GetStartTimeSuccessState());
    } else {
      log('pickedStartTime ==null');
      scheduledTime =
          TimeOfDay(hour: currentDate.hour, minute: currentDate.minute);
      emit(GetStartTimeErrorState());
    }
  }

  //! get EndTime From User
  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());

    TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedEndTime != null) {
      endTime = pickedEndTime.format(context);
      emit(GetEndTimeSuccessState());
    } else {
      log('pickedStartTime ==null');
      emit(GetEndTimeErrorState());
    }
  }

  //! Change CheckMarkIndex
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

  //! Change CheckMarkIndex
  void changeCheckMarkIndex(index) {
    currentIndex = index;
    emit(ChangeCheckMarkIndexState());
  }

  //! get Selected Date

  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selectedDate = date;

    emit(GetSelectedDateSuccessState());
    getTasks();
  }

  //! Insert Task

  List<TaskModel> tasksList = [];
  void insertTask() async {
    emit(InsertTaskLoadingState());

    try {
      await Future.delayed(const Duration(seconds: 2));
      await sl<SqfliteHelper>().insertToDB(
        TaskModel(
          date: DateFormat.yMd().format(currentDate),
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          isCompleted: 0,
          color: currentIndex,
        ),
      );

      titleController.clear();
      noteController.clear();
      emit(InsertTaskSuccessState());
      getTasks();
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

//! get Tasks
  void getTasks() async {
    emit(GetDateLoadingState());
    await sl<SqfliteHelper>().getFromDB().then((value) {
      tasksList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
            (element) => element.date == DateFormat.yMd().format(selectedDate),
          )
          .toList();
      emit(GetDateSuccessState());
    }).catchError((e) {
      log(e.toString());
      emit(GetDateErrorState());
    });
  }

  //update Task
  void updateTask(id) async {
    emit(UpdateTaskLoadingState());

    await sl<SqfliteHelper>().updateDB(id).then((value) {
      emit(UpdateTaskSuccessState());
      getTasks();
    }).catchError((e) {
      log(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

//delete task
  void deleteTask(id) async {
    emit(DeleteTaskLoadingState());

    await sl<SqfliteHelper>().deleteFromDB(id).then((value) {
      emit(DeleteTaskSuccessState());
      getTasks();
    }).catchError((e) {
      log(e.toString());
      emit(DeleteTaskErrorState());
    });
  }

  bool isDark = false;
  void changeTheme() async {
    isDark = !isDark;
    await sl<CacheHelper>().saveData(key: 'isDark', value: isDark);
    emit(ChangeThemeState());
  }

  void getTheme() async {
    isDark = await sl<CacheHelper>().getData(key: 'isDark');
    emit(GetThemeState());
  }
}
