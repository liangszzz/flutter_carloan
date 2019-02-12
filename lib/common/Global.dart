import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/User.dart';

///全局共享信息
class Global {
  Token token;

  User user;

  static Dio dio = Dio(Options(
    baseUrl: "http://192.168.1.12:8081/",
    connectTimeout: 10000,
    receiveTimeout: 100000,
    contentType: ContentType.json,
  ));

  factory Global() => _getInstance();

  static Global _instance;

  Global._internal();

  static Global _getInstance() {
    if (_instance == null) {
      _instance = new Global._internal();
    }
    return _instance;
  }

  Future<Response> dioPost(String url, [Map params]) {
    if (token != null) {
      dynamic tok = token.token;
      dio.options.headers.putIfAbsent("token", tok);
    }
    return dio.post(url, data: params);
  }
}
