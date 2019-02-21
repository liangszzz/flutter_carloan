import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/login/LoginPage.dart';
import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/sign/SignPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _MyAppStateful();
}

class _MyAppStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<_MyAppStateful> {
  Global global = new Global();

  var _logined = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "车贷系统",
        home: _toIndexPage(),
        theme: new ThemeData(
          primaryColor: Colors.white,
        ),
      );

  Widget _toIndexPage() {
    _checkDevice();
    _checkLogin();
    if (_logined) {
      return SignPage(bizOrderNo: "QSM20181213105740", channelType: 2);
    }
    return LoginPage();
  }

  ///判断用户是否已经登录
  void _checkLogin() async {
    Token token = await Token.loadToken();
    if (token != null && token.checkExpire()) {
      global.token = token;
      setState(() {
        _logined = true;
      });
      _loadTokenAndUserInfo();
    }
  }

  void _loadTokenAndUserInfo() async {
    if (_logined) return;
    var response = await global.post("login/appLogin/" + global.token.token);
    DataResponse d = DataResponse.fromJson(response);
    if (d.success()) global.loadTokenAndUserInfo(d);
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
