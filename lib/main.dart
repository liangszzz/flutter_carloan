import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/DataResponse.dart';
import 'package:flutter_carloan/app/Token.dart';
import 'package:flutter_carloan/common/DialogUtils.dart';
import 'package:flutter_carloan/common/updateVersion.dart';
import 'package:flutter_carloan/index/RootScene.dart';
import 'package:flutter_carloan/login/LoginPage.dart';
import 'package:flutter_carloan/app/Global.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Global global = Global();

  bool loginFlag = false;

  bool latestVersion = true;

  String signedPhone;

  @override
  void initState() {
    _checkVersion();
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
      theme: global.globalTheme,
    );
  }

  Widget _toIndexPage() {
    if (!latestVersion) {
      return updateVersionPage();
    }
    return LoginPage();
  }
  ///检查版本更新
  void _checkVersion() async {
    var response = await global.post("app/queryLatest");
    if (response["code"] == 0) {
      var updateVersion = response["entity"];
      if (global.currentVersion != updateVersion) {
        setState(() {
          this.latestVersion = false;
        });
      }
    }
  }
}
