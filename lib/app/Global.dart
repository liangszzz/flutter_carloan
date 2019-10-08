import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/DataResponse.dart';
import 'package:flutter_carloan/app/Token.dart';
import 'package:flutter_carloan/app/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

///全局共享信息
class Global {
  SharedPreferences preferences;

  Token token;

  User user;

  String currentVersion = "1.0.0";

  ThemeData globalTheme = ThemeData(
    primaryColor: Colors.white,
  );

  //本地开发环境
//  Dio dio = new Dio(BaseOptions(baseUrl: "http://192.168.2.16:8081/mobile/"));

  //局域网开发环境
//  Dio dio = new Dio(BaseOptions(baseUrl: "http://192.168.1.7:8081/mobile/"));
  //外网测试环境
//  Dio dio = new Dio(BaseOptions(baseUrl: "http://106.15.126.226:8081//mobile/"));
  //易通保理测试
//  Dio dio = new Dio(BaseOptions(baseUrl: "http://47.100.105.79/mobile/"));
  //易通保理生产
  Dio dio = new Dio(BaseOptions(baseUrl: "http://120.55.163.25/mobile/"));
  //生产环境
//  Dio dio = new Dio(BaseOptions(baseUrl: "http://carloan-manage.qsmartec.com/mobile/"));

  /// 0 安卓 1,IOS 2.windows 3.
  int DEVICE = 0;

  HttpClient httpClient = new HttpClient();

  ///验证码倒计时时间
  final int SECOND = 60;

  final int imageQuality = 50;

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
      Token token = Token(DateTime.parse(map['expire']), map['token']);
      this.token = token;
    }
    setKeyValue("phone", user.phone);
  }

  void setKeyValue(String key, String value) async {
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
    await preferences.setString(key, value);
  }

  Future<String> getValueByKey(String key) async {
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
    var keys = preferences.getKeys();
    if (keys.contains(key)) {
      return preferences.getString(key);
    }
    return null;
  }
}
