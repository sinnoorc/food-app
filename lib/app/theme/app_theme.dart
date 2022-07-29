import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_constants.dart';
import '../utils/color_utils.dart';

class AppTheme {
  static final AppTheme instance = AppTheme._internal();

  factory AppTheme() => instance;

  AppTheme._internal();

  ThemeData get theme => ThemeData(
        primarySwatch: generateMaterialColor(color: AppConstants.kPrimaryColor),
        useMaterial3: true,
        fontFamily: 'Roboto',
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      );
}
