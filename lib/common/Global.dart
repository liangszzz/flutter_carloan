import 'dart:convert';
import 'dart:io';

import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/User.dart';

///全局共享信息
class Global {
  Token token;

  User user;

  static const String SCHEME = "HTTP";

  static const String HOST = "192.168.1.12";

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
}
