import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/login/LoginPage.dart';
import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/me/MeScene.dart';
import 'package:flutter_carloan/sign/SignPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Global global = Global();

  bool loginFlag = false;

  @override
  void initState() {
    _checkLogin();
    sleep(Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _buildBody();

  Widget _buildBody() {
    if (Platform.isAndroid) {
      global.DEVICE = 0;
    } else if (Platform.isIOS) {
      global.DEVICE = 1;
    } else if (Platform.isWindows) {
      global.DEVICE = 2;
    }
    return MaterialApp(
      title: "车贷系统",
      home: _toIndexPage(),
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }

  Widget _toIndexPage() {
    if (loginFlag) {
      return MeScene();
//      return SignPage(bizOrderNo: "NM2018100822301386314973", channelType: 2);
/*      return AuditLendersPage(
        bizOrderNo: "NM2018100822301386314973",
        channelType: 2,
      );*/
    }
    return LoginPage();
  }

  ///判断用户是否已经登录
  void _checkLogin() async {
    Token token = await Token.loadToken();
    if (token != null && token.checkExpire()) {
      _loadTokenAndUserInfo(token);
    }
  }

  void _loadTokenAndUserInfo(Token token) async {
    var response = await global.post("login/appLogin/" + token.token);
    DataResponse d = DataResponse.fromJson(response);
    if (d.success()) {
      global.loadTokenAndUserInfo(d);
      global.token = token;
      setState(() {
        loginFlag = true;
      });
    }
  }
}
