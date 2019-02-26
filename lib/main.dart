import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/login/LoginPage.dart';
import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/sign/SignPage.dart';

import 'package:flutter_carloan/repayment/repayment_page.dart';
import 'package:flutter_carloan/order/OrderPage.dart';
import 'package:flutter_carloan/me/MeScene.dart';
import 'package:flutter_carloan/app/RootScene.dart';

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

  bool loginFlag = false;

  @override
  void initState() {
    _checkDevice();
    _checkLogin();
    sleep(Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "车贷系统",
//        home: RepaymentPage(
//          bizOrderNo: 'QSM-TEST123456789',
//        bizOrderNo: '31037863-031532073916',
//          isConfirm: false,
//        ),
//  home: OrderPage(
//    idCard: '341203197307200711',
//  ),
  home: RootScene(),
        theme: new ThemeData(
          primaryColor: Colors.white,
        ),
      );

  Widget _toIndexPage() {
    if (loginFlag) {
      return SignPage(bizOrderNo: "NM2018100822301386314973", channelType: 2);
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
