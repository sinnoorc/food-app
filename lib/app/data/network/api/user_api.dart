import 'package:dio/dio.dart';
import 'package:food_app/app/constants/app_url.dart';
import 'package:food_app/app/data/model/user.dart';
import 'package:food_app/app/data/network/service/api_service.dart';

class UserApi {
  final ApiService apiService = ApiService();

  Future<Response> login(String email, String password) async {
    try {
      var data = {
        'user_email': email,
        'user_password': password,
      };
      final Response response = await apiService.post(
        AppUrl.loginUrl,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> register(User user, String password) async {
    try {
      var data = {
        'user_firstname': user.firstName,
        'user_email': user.email,
        'user_phone': user.phone,
        'user_password': password,
        'user_lastname': "test ",
        'user_city': "kl",
        'user_zipcode': "123456"
      };
      final Response response = await apiService.post(
        AppUrl.registerUrl,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
