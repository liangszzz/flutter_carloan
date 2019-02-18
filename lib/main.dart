import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/RootScene.dart';
import 'package:flutter_carloan/login/LoginPage.dart';
import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/me/MeScene.dart';
import 'package:flutter_carloan/userInfo/UserInfo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: "hello word",
      home: RootScene(),
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }

  ///判断用户是否已经登录
  void checkLogin() async {
    Global global = new Global();
    Future<Token> token = Token.loadToken();

    token.then((value) {
      if (value != null && value.checkExpire()) {
        global.token = value;
      }
    }).catchError((error) {
      print(error);
    });

  }
}
