import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../widgets/custom_text_field.dart';
import '../../register/views/register_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            reverse: true,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: SvgPicture.asset(
                          'assets/image/login.svg',
                          height: constraints.maxHeight * 0.3,
                        ),
                      ),
                      const Spacer(),
                      FadeInUp(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: Text('Sign In', style: theme.textTheme.headline4)),
                              const SizedBox(height: 10),
                              CustomTextField(
                                label: 'Emil Address',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (GetUtils.isEmail(value) == false) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                label: 'Password',
                                controller: _passwordController,
                                obscureText: true,
                                isSuffixIcon: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              buildForgotPassword(theme),
                              const SizedBox(height: 20),
                              buildLogin(theme),
                              const SizedBox(height: 60),
                              buildSignUp(theme),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildForgotPassword(ThemeData theme) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Forgot Password?',
        style: theme.textTheme.caption?.copyWith(
          color: theme.primaryColor,
        ),
      ),
    );
  }

  Widget buildLogin(ThemeData theme) {
    return Obx(() => ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            primary: theme.primaryColor,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              FocusScope.of(Get.overlayContext!).unfocus();
              if (controller.isLoading) return;
              controller.login(
                email: _emailController.text,
                password: _passwordController.text,
              );
            }
          },
          child: controller.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('Login'),
        ));
  }

  Widget buildSignUp(ThemeData theme) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'I am new user ',
          style: theme.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'Sign Up',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showBarModalBottomSheet(
                    context: Get.overlayContext!,
                    builder: (context) => const RegisterView(isFromLoginPage: true),
                    isDismissible: false,
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
