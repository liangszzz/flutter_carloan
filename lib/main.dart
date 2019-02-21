import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/login/LoginPage.dart';
import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/Global.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Global global = new Global();

  @override
  Widget build(BuildContext context) {
    _checkDevice();
    _checkLogin();
    return new MaterialApp(
      title: "hello word",
      home: LoginPage(),
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }

  ///判断用户是否已经登录
  void _checkLogin() async {
    Future<Token> token = Token.loadToken();

    token.then((value) {
      if (value != null && value.checkExpire()) {
        global.token = value;
      }
    }).catchError((error) {
      print(error);
    });
  }

  ///检查设备
  void _checkDevice() {
    if (Platform.isAndroid) {
      global.DEVICE = 0;
    } else if (Platform.isIOS) {
      global.DEVICE = 1;
    } else if (Platform.isWindows) {
      global.DEVICE = 2;
    }
  }
}
