import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/core/database/cache/cache_helper.dart';
import 'package:todo_app/core/services/service.locator.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/core/widget/custom_elevated_button.dart';
import 'package:todo_app/core/widget/custom_text_button.dart';
import 'package:todo_app/features/auth/data/model/on_boarding_model.dart';
import 'package:todo_app/features/task/presentation/screens/home_page/home_page_screen.dart';

import '../../../../../core/common/commons.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: PageView.builder(
            itemCount: OnBoardingModel.onBoardingScreen.length,
            controller: controller,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  //! Skip Button
                  index != 2
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTextButton(
                            onPressed: () {
                              controller.jumpToPage(2);
                            },
                            text: AppStrings.skip,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: AppColors.white.withOpacity(0.44),
                                ),
                          ))
                      : SizedBox(
                          height: 40.h,
                        ),
                  SizedBox(
                    height: 16.h,
                  ),
                  //! onboarding  Image
                  Image.asset(
                      OnBoardingModel.onBoardingScreen[index].imagePath),
                  SizedBox(
                    height: 16.h,
                  ),
                  //! onboarding indicator dots
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.grey,
                      dotHeight: 8.h,
                      dotWidth: 10.w,
                      spacing: 8,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  //! onboarding title String
                  Text(
                    OnBoardingModel.onBoardingScreen[index].title,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 32.sp,
                        ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  //! onboarding Subtitle String
                  Text(
                      textAlign: TextAlign.center,
                      OnBoardingModel.onBoardingScreen[index].subTitle,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 16.sp)),
                  SizedBox(
                    height: 70.h,
                  ),

                  //! onboarding buttons
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      index != 0
                          ? CustomTextButton(
                              onPressed: () {
                                controller.previousPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                              text: AppStrings.back,
                            )
                          : Container(),
                      const Spacer(),
                      index != 2
                          ? CustomElevatedButton(
                              onPressed: () {
                                controller.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                );
                              },
                              text: AppStrings.next,
                            )
                          : CustomElevatedButton(
                              onPressed: () async {
                                // navigator();
                                await sl<CacheHelper>()
                                    .saveData(
                                        key: AppStrings.onboardingKey,
                                        value: true)
                                    .then(
                                  (value) {
                                    log('onboarding saved');
                                    navigate(
                                      context: context,
                                      screen: const HomePageScreen(),
                                    );
                                  },
                                ).catchError(
                                  (error) {
                                    log(
                                      error.toString(),
                                    );
                                  },
                                );
                              },
                              text: AppStrings.getStarted,
                            )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
