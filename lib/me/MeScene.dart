import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/DialogUtils.dart';
import 'package:flutter_carloan/carInfo/CarInfoPage.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/FileUtil.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/login/LoginPage.dart';
import 'package:flutter_carloan/me/Screen.dart';
import 'package:flutter_carloan/me/UpdateMePage.dart';
import 'package:flutter_carloan/message/MessageItem.dart';
import 'package:flutter_carloan/my_bank_card/my_bank_card_page.dart';
import 'package:flutter_carloan/update_log/update_logs_page.dart';
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

  bool isReload = false;

  var bizOrderNo;

  var channelType;

  var orderStatus;

  var applyAmount = 0.0;

  var wxAppConfirm;

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
                MeHeader(applyAmount: applyAmount.toString()),
                SizedBox(height: 10),
                _buildCells(context),
              ],
            ),
          ),
        ),
        onWillPop: () {
          ///提示是否退出
          DialogUtils.showConfirmDialog(context, "确认要退出吗?", "", () {
            exit(0);
          }, null);
        },
      );

  Widget _buildCells(BuildContext context) {
    _getRecentOrder();

    return Container(
      child: Column(
        children: <Widget>[
          MeCell(
            title: '我的基本信息',
            iconName: 'assets/images/mine.png',
            onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new UserInfoPage(
                          bizOrderNo: bizOrderNo,
                          channelType: channelType,
                          wxAppConfirm: wxAppConfirm,
                          fromPage: 2)),
                );
            },
          ),
          MeCell(
            title: '我的车辆信息',
            iconName: 'assets/images/car.png',
            onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new CarInfoPage(
                          bizOrderNo: bizOrderNo,
                          channelType: channelType,
                          wxAppConfirm : wxAppConfirm,
                          fromPage: 2)),
                );
            },
          ),
          MeCell(
            title: '我的消息',
            iconName: 'assets/images/message.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyMessage(phone: '13770207216');
              }));
            },
          ),
          MeCell(
            title: '我的银行卡',
            iconName: 'assets/images/bank.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyBankCardPage(idCard: global.user.idCard,);
              }));
            },
          ),
          MeCell(
            title: '更新日志',
            iconName: 'assets/images/update.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdateLogsPage();
              }));
            },
          ),
          MeCell(
            title: '修改信息',
            iconName: 'assets/images/setting.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdateMePage();
              }));
            },
          ),
          new Container(
            height: 20.0,
            color: const Color(0xffebebeb),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Text("",
                      style: TextStyle(fontSize: 12.0, color: Colors.black)),
                ),
              ],
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {
                      _logOut();
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    //通过控制 Text 的边距来控制控件的高度
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                      child: new Text(
                        "安全退出",
                        style: TextStyle(color: Colors.red, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            height: 20.0,
            color: const Color(0xffebebeb),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Text("",
                      style: TextStyle(fontSize: 12.0, color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getRecentOrder() async {
    if(global.user.idCard == null || global.user.idCard == ''){
      return;
    }
    if (!isReload) {
      isReload = true;
      var response =
          await global.post("user/getRecentOrder/"+ global.user.idCard);
      DataResponse d = DataResponse.fromJson(response);
      setState(() {
        if (d.success()) {
          Map<String, Object> map = d.entity as Map;
          if(map != null){
            bizOrderNo = map['biz_order_no'];
            channelType = map['channel_type'];
            orderStatus = map['order_status'];
            applyAmount = map['apply_amount'];
            wxAppConfirm = map['wx_app_confirm'];
          }
        }
      });
    }
  }

  ///退出登录方法
  void _logOut() {
    showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('是否确认退出登录吗?', style: new TextStyle(fontSize: 17.0)),
            actions: <Widget>[
              new FlatButton(
                child: new Text('取消'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('确定'),
                onPressed: (){
                  FileUtil fileUtil = FileUtil("token");
                  fileUtil.delete();
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginPage()));
                },
              )
            ],
          );
        }
    );
  }
}
