part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const onboarding = _Paths.onboarding;
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const welcome = _Paths.welcome;
}

abstract class _Paths {
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const welcome = '/welcome';
}
