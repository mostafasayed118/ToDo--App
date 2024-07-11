import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_strings.dart';

class OnBoardingModel {
  final String imagePath;
  final String title;
  final String subTitle;
  OnBoardingModel(
      {required this.imagePath, required this.title, required this.subTitle});

  static List<OnBoardingModel> onBoardingScreen = [
    OnBoardingModel(
        imagePath: AppAssets.onBoarding1,
        title: AppStrings.onBoardingTitleOne,
        subTitle: AppStrings.onBoardingSubTitleOne),
    OnBoardingModel(
        imagePath: AppAssets.onBoarding2,
        title: AppStrings.onBoardingTitleTwo,
        subTitle: AppStrings.onBoardingSubTitleTwo),
    OnBoardingModel(
        imagePath: AppAssets.onBoarding3,
        title: AppStrings.onBoardingTitleThree,
        subTitle: AppStrings.onBoardingSubTitleThree),
  ];
}
