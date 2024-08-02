import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/theme.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/features/auth/presentation/screens/splash_screen/splash_screen.dart';
import 'package:todo_app/features/task/cubit/task_cubit.dart';
import 'package:todo_app/features/task/cubit/task_state.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: getAppLightTheme(),
                darkTheme: getAppDarkTheme(),
                themeMode: BlocProvider.of<TaskCubit>(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                title: AppStrings.appName,
                home: const SplashScreen(),
              );
            },
          );
        });
  }
}
