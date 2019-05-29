import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/DataResponse.dart';
import 'package:flutter_carloan/app/Token.dart';
import 'package:flutter_carloan/app/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences;

///全局共享信息
class Global {
  Token token;

  User user;

  String currentVersion = "1.0.1";

  ThemeData globalTheme = ThemeData(
    primaryColor: Colors.white,
  );
//http://106.15.126.226:8081/
  Dio dio = new Dio(BaseOptions(baseUrl: "http://106.15.126.226:8081/"));

  /// 0 安卓 1,IOS 2.windows 3.
  int DEVICE = 0;

  HttpClient httpClient = new HttpClient();

  ///验证码倒计时时间
  final int SECOND = 60;

  factory Global() => _getInstance();

  static Global _instance;

  Global._internal();

  static Global _getInstance() {
    if (_instance == null) {
      _instance = new Global._internal();
    }
    return _instance;
  }

  Future<Map> post(String url, [queryParameters]) async {
    if (token != null && token.token != null) {
      dio.options.headers.putIfAbsent("token", () => token.token);
    } else {
      dio.options.headers.remove("token");
    }
    Response responseBody =
        await dio.post(url, queryParameters: queryParameters);
    return responseBody.data;
  }

  Future<Map> postFormData(String url, [data]) async {
    if (token != null && token.token != null) {
      dio.options.headers.putIfAbsent("token", () => token.token);
    } else {
      dio.options.headers.remove("token");
    }
    Response responseBody = await dio.post(url, data: data);
    return responseBody.data;
  }

  void loadTokenAndUserInfo(DataResponse d) {
    Map<String, dynamic> map = d.entity as Map;
    //将用户信息写入global
    User user = User.fromJson(map);
    this.user = user;
    //将token信息写入global
    if (map['expire'] != null && map['token'] != null) {
      Token token = Token.parseToken(map['expire'] + map['token']);
      token.writeToken();
      this.token = token;
    }
  }
}
