import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/login.dart';
import '../modules/onboarding/onboarding.dart';
import '../modules/register/register.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final GetStorage storage = GetStorage();

  static bool get isLoggedIn => storage.read('isLoggedIn') ?? false;

  static final initial = !isLoggedIn ? Routes.onboarding : Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.downToUp,
      transitionDuration: 400.milliseconds,
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.welcome,
      page: () => const WelcomeView(),
      transition: Transition.circularReveal,
      transitionDuration: 600.milliseconds,
    ),
  ];
}
