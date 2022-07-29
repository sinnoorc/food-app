import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/onboarding.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  final RxInt _selectedPageIndex = RxInt(0);

  int get selectedPageIndex => _selectedPageIndex.value;
  set selectedPageIndex(int value) => _selectedPageIndex.value = value;

  bool get isLastPage => selectedPageIndex == onboardingPages.length - 1;
  bool get isFirstPage => selectedPageIndex == 0;

  final PageController pageController = PageController();

  void nextPage() {
    if (!isLastPage) {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.easeIn);
    } else {
      Get.offAllNamed(Routes.welcome);
    }
  }

  void previousPage() {
    pageController.previousPage(duration: 300.milliseconds, curve: Curves.easeIn);
  }

  final List<Onboarding> onboardingPages = [
    Onboarding(
      title: 'Order Your Food',
      description: 'Now you can order food any time \nright from your mobile.',
      image: 'assets/image/order.png',
    ),
    Onboarding(
      title: 'Cooking Safe Food',
      description: 'We are maintain safety and We keep \nclean while making food.',
      image: 'assets/image/cook.png',
    ),
    Onboarding(
      title: 'Quick Delivery',
      description: 'Orders your favorite meals will be \nimmediately deliver',
      image: 'assets/image/deliver.png',
    ),
  ];
}
