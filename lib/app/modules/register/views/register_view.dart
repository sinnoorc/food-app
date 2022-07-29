import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/user.dart';
import '../../../widgets/custom_text_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key, this.isFromLoginPage = false}) : super(key: key);

  final bool isFromLoginPage;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobilController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeInUp(
      child: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Create Account',
                    style: theme.textTheme.headline4,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Full Name',
                  controller: _fullNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
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
                  label: 'Mobile Number',
                  controller: _mobilController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (value.length > 10) {
                      return 'Please enter valid mobile number';
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
                const SizedBox(height: 30),
                buildLogin(theme),
                const SizedBox(height: 50),
                buildSignUp(theme),
              ],
            ),
          ),
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
              FocusScope.of(context).unfocus();
              if (controller.isLoading) return;
              final user = User(
                firstName: _fullNameController.text,
                email: _emailController.text,
                phone: _emailController.text,
              );
              controller.register(user, _passwordController.text);
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
              : const Text('Sign Up'),
        ));
  }

  Widget buildSignUp(ThemeData theme) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'I am already member ',
          style: theme.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'Sign In',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.back();
                  if (!widget.isFromLoginPage) {
                    Get.toNamed('/login');
                  }
                },
            ),
          ],
        ),
      ),
    );
  }
}
