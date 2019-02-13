import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/login/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Global global = new Global();

  @override
  Widget build(BuildContext context) {
    _checkToken();
    return new MaterialApp(
      title: "车贷系统",
      home: LoginPage(),
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }

  ///判断用户是否已经登录
  void _checkToken() async {
    var token = await Token.loadToken();
    if (token != null && token.checkExpire()) {
      //获取用户信息
      _loadTokenAndUserInfo();
    }
  }

  void _loadTokenAndUserInfo() async {
    var response = await global.post("login/appLogin/" + global.token.token);
    DataResponse d = DataResponse.fromJson(json.decode(response));
    global.loadTokenAndUserInfo(d);
  }
}
