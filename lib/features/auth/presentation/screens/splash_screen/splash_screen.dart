import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/database/cache/cache_helper.dart';
import 'package:todo_app/core/services/service.locator.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/features/auth/presentation/screens/on_boarding_screen/on_boarding_screen.dart';

import '../../../../task/cubit/task_cubit.dart';
import '../../../../task/presentation/screens/home_page/home_page_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    navigatorWithFuture();
  }

//presentation
  void navigatorWithFuture() {
    bool isVisited =
        sl<CacheHelper>().getData(key: AppStrings.onboardingKey) ?? false;
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return isVisited ? const HomePageScreen() : OnBoardingScreen();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<TaskCubit>().isDark
          ? AppColors.background
          : AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 40.sp,
                    color: context.read<TaskCubit>().isDark
                        ? AppColors.white
                        : AppColors.background,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
