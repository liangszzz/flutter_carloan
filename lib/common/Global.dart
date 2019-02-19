import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences;

///全局共享信息
class Global {
  Token token;

  User user;

  Dio dio = new Dio(BaseOptions(baseUrl: "http://192.168.1.12:8081/"));

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
      dynamic tmp = token.token;
      dio.options.headers.putIfAbsent("token", tmp);
    } else {
      dio.options.headers.remove("token");
    }
    Response responseBody = await dio.post(url, queryParameters: queryParameters);
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
