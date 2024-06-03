import 'package:foodorder/app/core/constant/constText.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;
  final String btnTitle;
  final welcomeKey;

  OnboardingModel(
      {required this.title,
      required this.description,
      required this.imagePath,
      this.btnTitle = 'Get Started',
      this.welcomeKey = false});
}

List<OnboardingModel> onboardingData = [
  OnboardingModel(
      title: ConstantText.welcome,
      description: ConstantText.welcomeDescription,
      imagePath: 'assets/images/onboarding.png',
      btnTitle: ConstantText.getStarted,
      welcomeKey: false),
  OnboardingModel(
      title: ConstantText.favorites,
      description: ConstantText.favoritesDescription,
      imagePath: 'assets/images/onboarding1.png',
      btnTitle: ConstantText.next,
      welcomeKey: true),
  OnboardingModel(
      title: ConstantText.offers,
      description: ConstantText.offersDescription,
      imagePath: 'assets/images/onboarding2.png',
      btnTitle: ConstantText.next,
      welcomeKey: true),
  OnboardingModel(
      title: ConstantText.food,
      description: ConstantText.foodDescription,
      imagePath: 'assets/images/onboarding3.png',
      btnTitle: ConstantText.next,
      welcomeKey: true),
];
