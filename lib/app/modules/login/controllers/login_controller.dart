import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_app/app/data/network/api/user_api.dart';
import 'package:food_app/app/data/network/service/api_exception.dart';
import 'package:food_app/app/utils/utils.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final RxBool _isLoading = RxBool(false);

  bool get isLoading => _isLoading.value;

  UserApi userApi = UserApi();

  final GetStorage _storage = GetStorage();

  login({required String email, required String password}) async {
    _isLoading.value = true;
    try {
      final response = await userApi.login(email, password);
      if (response.statusCode == 200) {
        _isLoading.value = false;
        var json = jsonDecode(response.data);
        Get.log(json.toString());
        bool status = json['status'];
        var msg = json['msg'];
        if (!status) {
          Utils.showSnackbar(
            title: 'Oops! Login Failed',
            message: msg,
          );
        } else {
          final user = json['user_data'][0];

          await _storage.write('isLoggedIn', true);
          await _storage.write('name', user['user_firstname']);
          await _storage.write('email', user['user_email']);
          await _storage.write('phone', user['user_phone']);
          await _storage.write('city', user['user_city']);
          await _storage.write('pincode', user['user_zipcode']);
          Get.offNamedUntil(Routes.home, (route) => false);
        }
      }
    } on DioError catch (e) {
      _isLoading.value = false;
      final errorMessage = ApiException.fromDioError(e).toString();
      return Utils.showSnackbar(
        title: 'Oops!',
        message: errorMessage,
      );
    } catch (e) {
      _isLoading.value = false;
      Get.log('Error: $e');
    }
  }
}
