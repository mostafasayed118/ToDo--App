import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/app.dart';
import 'package:todo_app/core/bloc/bloc_observer.dart';
import 'package:todo_app/core/database/cache/cache_helper.dart';
import 'package:todo_app/core/database/sqflite_helper/sqflite_helper.dart';
import 'package:todo_app/core/services/service.locator.dart';
import 'package:todo_app/features/task/cubit/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await CacheHelper().init();
  Bloc.observer = MyBlocObserver();
  await setup();
  await sl<CacheHelper>().init();
  sl<SqfliteHelper>().initDB();
  runApp(
    BlocProvider(
      create: (context) => TaskCubit()
        ..getTheme()
        ..getTasks(),
      child: const ToDoApp(),
    ),
  );
}
