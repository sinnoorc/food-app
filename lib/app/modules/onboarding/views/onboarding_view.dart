import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../data/model/onboarding.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: buildAppBar(theme),
        body: SafeArea(
          child: Padding(
            padding: AppConstants.kDefaultPadding,
            child: Stack(
              children: [
                buildPageView(theme),
                buildIndicator(theme),
                buildFloatingActionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      leading: Obx(() => AnimatedOpacity(
            opacity: controller.isFirstPage ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              color: Colors.grey,
              onPressed: controller.previousPage,
              icon: const Icon(Icons.chevron_left),
            ),
          )),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.grey,
          ),
          onPressed: () => Get.offAllNamed(Routes.welcome),
          child: const Text('Skip'),
        ),
      ],
    );
  }

  Widget buildPageView(ThemeData theme) {
    return PageView.builder(
        controller: controller.pageController,
        onPageChanged: (int index) => controller.selectedPageIndex = index,
        itemCount: controller.onboardingPages.length,
        itemBuilder: (context, index) {
          Onboarding onboardingData = controller.onboardingPages[index];
          return buildPage(onboardingData, theme);
        });
  }

  Widget buildPage(Onboarding onboardingData, ThemeData theme) {
    return FadeInRight(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            onboardingData.title,
            style: theme.textTheme.headline4?.copyWith(color: theme.primaryColor),
          ),
          const SizedBox(height: 14),
          Text(
            onboardingData.description,
            textAlign: TextAlign.start,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 90),
          Center(
            child: Image.asset(onboardingData.image),
          ),
          const SizedBox(height: 90),
          const Spacer(),
        ],
      ),
    );
  }

  Widget buildIndicator(ThemeData theme) {
    return Positioned(
      left: 0,
      bottom: 20,
      child: Row(
        children: List.generate(
          controller.onboardingPages.length,
          (index) => Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(4),
                width: 10,
                height: controller.selectedPageIndex == index ? 10 : 6,
                decoration: BoxDecoration(
                  color:
                      controller.selectedPageIndex == index ? theme.primaryColor : theme.primaryColor.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              )),
        ),
      ),
    );
  }

  Widget buildFloatingActionButton() => Positioned(
        right: 0,
        bottom: 15,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
          onPressed: controller.nextPage,
          child: Obx(() => Text(controller.isLastPage ? 'Start' : 'Next')),
        ),
      );
}
