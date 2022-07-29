import 'package:flutter/material.dart';
import 'package:food_app/app/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../routes/app_pages.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: Padding(
        padding: AppConstants.kDefaultPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            Text(
              'Account Created Successfully',
              style: theme.textTheme.headline6,
            ),
            const SizedBox(height: 10),
            LottieBuilder.asset('assets/animation/successful.json', repeat: false),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                primary: theme.primaryColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Get.back();
                Get.offAllNamed(Routes.login);
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
