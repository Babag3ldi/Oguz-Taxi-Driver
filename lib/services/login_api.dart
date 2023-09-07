import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../const/enums.dart';
import '../model/user_model.dart';
import 'network_class.dart';

class LoginApi with ChangeNotifier {
  UserModel? user;
  ApiStatus status = ApiStatus.nothing;
  set useri(UserModel userModel) => user = userModel;
  Future<void> sendCode(String email) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      var response = await NetworkHandler.http
          .post("${NetworkHandler.baseUrl}code/email/", data: {'email': email});
      // print(response.statusCode);
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);

        if (e.response != null) print("Error= ${e.response!.realUri}");
        if (e.response != null) print(e.response!.data);
      }
      status = ApiStatus.error;
      notifyListeners();
    }
  }

  Future<void> sendCodePhone(String phone) async {
    status = ApiStatus.loading;
    notifyListeners();

    try {
      var response = await NetworkHandler.http.post(
          "${NetworkHandler.baseUrl}authentication/code/phone/",
          data: {'phone': phone});
      //  print(response.statusCode);
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);

        if (e.response != null) print("Error= ${e.response!.realUri}");
        if (e.response != null) print(e.response!.data);
      }
      status = ApiStatus.error;
      notifyListeners();
    }
  }

  Future<void> getToken({String? code, String? phone}) async {
    status = ApiStatus.loading;
    notifyListeners();
    Map<String, String> data = {"phone": phone!, "code": code!};
    if (kDebugMode) {
      print(data);
    }
    try {
      var response = await NetworkHandler.http.post(
          "${NetworkHandler.baseUrl}authentication/token/",
          data: jsonEncode(data));
      //print(response.statusCode);
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        // String token = response.data["token"];
        // user = UserModel.fromJson(response.data);
        log('${response.data}');
        addUser(
          UserModel(
            token: response.data['token'],
          ),
        );

        //UserModel(token: token, userName: username, name: );

        notifyListeners();
        if (kDebugMode) {
          print(response.data["token"]);
        }

        await NetworkHandler.setRequestHeaders(
          isLoggedIn: true,
          // token: token,
        );
        // await addUser(user!);

        return;
      }
      status = ApiStatus.error;
      notifyListeners();
    } on DioException catch (e) {
      status = ApiStatus.error;
      if (kDebugMode) {
        print(e.error);

        if (e.response != null) print("Error= ${e.response!.realUri}");
        if (e.response != null) print(e.response!.data);
      }
      notifyListeners();
    }
  }

  addUser(UserModel user) async {
    Box box;
    if (Hive.isBoxOpen("LoginBox") == false) {
      await Hive.openBox("LoginBox");
      box = Hive.box('LoginBox');
    } else {
      box = Hive.box('LoginBox');
    }

    box.put('user', user);

    // await box.put('login', seller.email);
    // await box.put('parol', seller.password);
  }
}
