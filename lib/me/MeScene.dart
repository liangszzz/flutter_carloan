import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/DialogUtils.dart';
import 'package:flutter_carloan/carInfo/CarInfo.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/me/UpdatePwdPage.dart';
import 'package:flutter_carloan/me/Screen.dart';
import 'package:flutter_carloan/me/UpdateUserInfoPage.dart';
import 'package:flutter_carloan/message/MessageItem.dart';
import 'package:flutter_carloan/userInfo/UserInfoPage.dart';

import 'MeCell.dart';
import 'MeHeader.dart';

class MeScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _MeSceneStateful();
}

class _MeSceneStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeSceneState();
}

class _MeSceneState extends State<_MeSceneStateful> {
  Global global = new Global();

  ///page==0 默认主页,_page==1 修改信息页
  int _page = 0;

  @override
  Widget build(BuildContext context) => WillPopScope(
        child: Scaffold(
          appBar: PreferredSize(
            child: Container(color: Colors.white),
            preferredSize: Size(Screen.width, 0),
          ),
          body: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                MeHeader(),
                SizedBox(height: 10),
                _buildBody(context),
              ],
            ),
          ),
        ),
        onWillPop: () {
          if (_page != 0) {
            setState(() {
              _page = 0;
            });
          } else {
            ///提示是否退出
            DialogUtils.showConfirmDialog(context, "确认要退出吗?", "", () {
              exit(0);
            }, null);
          }
        },
      );

  Widget _buildBody(BuildContext context) {
    switch (_page) {
      case 0:
        return _buildCells(context);
      case 1:
        return _buildUpdateMe(context);
      default:
        return null;
    }
  }

  Widget _buildCells(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MeCell(
            title: '我的基本信息',
            iconName: 'img/me_wallet.png',
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new UserInfoPage()),
              );
            },
          ),
          MeCell(
            title: '我的车辆信息',
            iconName: 'img/me_record.png',
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new UserInfoPage()),
              );
            },
          ),
          MeCell(
            title: '我的消息',
            iconName: 'img/me_buy.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyMessage();
              }));
            },
          ),
          MeCell(
            title: '我的银行卡',
            iconName: 'img/me_vip.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CarInfo();
              }));
            },
          ),
          MeCell(
            title: '更新日志',
            iconName: 'img/me_coupon.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CarInfo();
              }));
            },
          ),
          MeCell(
            title: '修改信息',
            iconName: 'img/me_coupon.png',
            onPressed: () {
              setState(() {
                _page = 1;
              });
            },
          ),
          MeCell(
            title: '退出登录',
            iconName: 'img/me_setting.png',
            onPressed: () {
              showDialog<Null>(
                context: context,
                barrierDismissible: false, // 不能点击对话框外关闭对话框，必须点击按钮关闭
                builder: (BuildContext context) {
                  return new AlertDialog(
                    title: new Text('提示'),
                    content: new Text('是否退出当前账号'),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('确认'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          print('点击了确认按钮');
                        },
                      ),
                      new FlatButton(
                        child: new Text('取消'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          print('点击了取消按钮');
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateMe(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MeCell(
            title: '更新个人信息',
            iconName: 'img/me_vip.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdateUserInfoPage();
              }));
            },
          ),
          MeCell(
            title: '修改密码',
            iconName: 'img/me_coupon.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdatePwdPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
