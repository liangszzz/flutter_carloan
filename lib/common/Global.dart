import 'dart:convert';
import 'dart:io';

import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences;

///全局共享信息
class Global {
  Token token;

  User user;

  static const String SCHEME = "HTTP";

  static const String HOST = "192.168.1.13";

  static const int PORT = 8081;

  factory Global() => _getInstance();

  static Global _instance;

  Global._internal();

  static Global _getInstance() {
    if (_instance == null) {
      _instance = new Global._internal();
    }
    return _instance;
  }

  Future<String> post(String url, [queryParameters]) async {
    HttpClient httpClient = new HttpClient();
    Uri uri = Uri(
        scheme: SCHEME,
        host: HOST,
        port: PORT,
        path: url,
        queryParameters: queryParameters);
    HttpClientRequest request = await httpClient.postUrl(uri);

    if (token != null && token.token != null) {
      request.headers.add("token", token.token);
    }

    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
    return responseBody;
  }

  void loadTokenAndUserInfo(DataResponse d) {
    Map<String, dynamic> map = d.entity as Map;
    //将用户信息写入global
    User user = User.fromJson(map);
    this.user = user;
    //将token信息写入global
    if (map['expire'] != null && map['token'] != null) {
      Token token = Token.parseToken(map['expire'] + map['token']);
      this.token.writeToken();
      this.token = token;
    }
  }
}
