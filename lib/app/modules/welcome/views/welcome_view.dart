import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../../register/views/register_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.kDefaultPadding,
          child: Column(
            children: [
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: size.height * 0.65,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text('Food App', style: theme.textTheme.headline3),
                      SvgPicture.asset(
                        'assets/image/welcome.svg',
                        height: size.height * 0.5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeInUp(
                child: Column(
                  children: [
                    Text(
                      'Welcome to Food App',
                      style: theme.textTheme.headline6,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: theme.primaryColor,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => Get.toNamed(Routes.login),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 15),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: theme.primaryColor,
                        ),
                      ),
                      onPressed: () {
                        showBarModalBottomSheet(
                          context: Get.overlayContext!,
                          builder: (context) => const RegisterView(),
                          isDismissible: false,
                          enableDrag: false,
                        );
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
