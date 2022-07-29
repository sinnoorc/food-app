import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_app/app/data/model/user.dart';
import 'package:food_app/app/widgets/success_widget.dart';
import 'package:get/get.dart' hide Response;

import '../../../data/network/api/user_api.dart';
import '../../../data/network/service/api_exception.dart';
import '../../../utils/utils.dart';

class RegisterController extends GetxController {
  final RxBool _isLoading = RxBool(false);

  bool get isLoading => _isLoading.value;

  UserApi userApi = UserApi();

  register(User user, String password) async {
    _isLoading.value = true;
    try {
      final response = await userApi.register(user, password);
      if (response.statusCode == 200) {
        _isLoading.value = false;
        var json = jsonDecode(response.data);
        Get.log(json.toString());

        bool status = json['status'];
        var msg = json['msg'];
        if (!status) {
          Utils.showSnackbar(
            title: 'Oops! Register Failed',
            message: msg,
          );
        } else {
          Get.dialog(
            const SuccessWidget(),
            barrierDismissible: false,
          );
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
