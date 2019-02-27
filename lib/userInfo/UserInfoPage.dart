import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carloan/app/DialogUtils.dart';
import 'package:flutter_carloan/carInfo/CarInfoPage.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/common/SysDict.dart';
import 'package:flutter_carloan/userInfo/ClContactInfo.dart';
import 'package:flutter_carloan/userInfo/ClUserInfo.dart';
import 'package:flutter_carloan/userInfo/ShowPhoto.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends StatefulWidget {
  final String bizOrderNo;
  final int channelType;
  final int wxAppConfirm;

  /// 0:app进单 1：订单页查看详情 2：我的页面
  final int fromPage;

  const UserInfoPage(
      {Key key, this.bizOrderNo, this.channelType, this.fromPage, this.wxAppConfirm})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _UserInfoPageState();
  }
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool isReload = false;

  String biz_order_no = "";

  String userName = "";
  String idCard = "";
  String idCardAddress = "";
  String residentialAddress = "";
  String phoneNo = "";

  ///婚姻状况
  List maritalList = new List();
  int maritalValue;
  var mariLabel = "";

  ///健康状况
  int healthValue;
  var healthLabel = "";
  List healthList = new List();

  ///身份类型
  int identityTypeValue;
  var identityTypeLabel = "";
  List identityTypeList = new List();

  ///最高学历
  int degreeValue;
  var degreeLabel = "";
  List degreeList = new List();

  ///客户职业信息
  int customerInfoValue;
  var customerInfoLabel = "";
  List customerInfoList = new List();

  ///开户行
  String bankName = "";
  List bankNameList = new List();
  int bankNameValue = 0;

  ///银行卡类型
  int bankCardValue;
  var bankCardLabel = "";
  List bankCardList = new List();

  ///联系人关系
  String contactPhone = "";
  String contactName = "";
  int relationShipValue;
  var relationShipLabel = "";
  List relationShipList = new List();

  String companyName = "";
  String companyPhone = "";
  String wxNumber = "";
  String personalIncome = "";
  String reservePhoneNo = "";
  String bankAccount = "";

  String _time = "2019-02-22";

  List<String> idCardImageList = new List();

  String openId = "";

  String defaultImageUrl =
      "http://106.14.239.49/group1/M00/04/4D/ag7vMVxuXfyAVvLmAAADgDq1o2k710.png";

  int formType = 0;

  ///控制输入框是否允许输入
  bool canWrite = false;

  String buttonName = "下一步";

  ///借款用途
  List<String> borrowUse = [
    '请选择',
    '消费',
    '汽车',
    '医美',
    '旅游',
    '教育',
    '3C',
    '家装',
    '租房',
    '租赁',
    '农业'
  ];
  String borrowUseLabel = "请选择";
  int borrowUseValue = 0;

  @override
  Widget build(BuildContext context) {
      _getUserInfo(widget.bizOrderNo, widget.channelType, widget.fromPage);


    ///婚姻状况
    if (maritalList.length > 0) {
      for (int i = 0; i < maritalList.length; i++) {
        if (maritalValue == int.parse(maritalList[i].value)) {
          mariLabel = maritalList[i].label;
        }
      }
    }

    ///健康状况
    if (healthList.length > 0) {
      for (int i = 0; i < healthList.length; i++) {
        if (healthValue == int.parse(healthList[i].value)) {
          healthLabel = healthList[i].label;
        }
      }
    }

    ///身份类型
    if (identityTypeList.length > 0) {
      for (int i = 0; i < identityTypeList.length; i++) {
        if (identityTypeValue == int.parse(identityTypeList[i].value)) {
          identityTypeLabel = identityTypeList[i].label;
        }
      }
    }

    ///最高学历
    if (degreeList.length > 0) {
      for (int i = 0; i < degreeList.length; i++) {
        if (degreeValue == int.parse(degreeList[i].value)) {
          degreeLabel = degreeList[i].label;
        }
      }
    }

    ///客户职业信息
    if (customerInfoList.length > 0) {
      for (int i = 0; i < customerInfoList.length; i++) {
        if (customerInfoValue == int.parse(customerInfoList[i].value)) {
          customerInfoLabel = customerInfoList[i].label;
        }
      }
    }

    ///银行卡类型
    if (bankCardList.length > 0) {
      for (int i = 0; i < bankCardList.length; i++) {
        if (bankCardValue == int.parse(bankCardList[i].value)) {
          bankCardLabel = bankCardList[i].label;
        }
      }
    }

    ///联系人关系
    if (relationShipList.length > 0) {
      for (int i = 0; i < relationShipList.length; i++) {
        if (relationShipValue == int.parse(relationShipList[i].value)) {
          relationShipLabel = relationShipList[i].label;
        }
      }
    }

    ///银行名
    if (bankNameList.length > 0) {
      if (bankNameValue >= 0) {
        bankName = bankNameList[bankNameValue];
      }
    }

    List<Widget> list = <Widget>[
      new Container(
        height: 24.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('      信息有误请及时联系客户经理修改',
                  style: TextStyle(
                      fontSize: 12.0, color: const Color(0xffAAAAAA))),
            ),
          ],
        ),
      ),

      ///真实姓名
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '真实姓名',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                enabled: canWrite,
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$userName",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onSubmitted: (text) {
                  userName = text;
                },
              ),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///身份证号
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '身份证号',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                enabled: canWrite,
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$idCard",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onSubmitted: (text) {
                  idCard = text;
                },
              ),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///身份证地址
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '身份证地址',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$idCardAddress",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onSubmitted: (text) {
                  idCardAddress = text;
                },
              ),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///现居地址
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '现居地址',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$residentialAddress",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onSubmitted: (text) {
                  residentialAddress = text;
                },
              ),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///手机号码
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '手机号码',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$phoneNo",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                ],
                maxLines: 1,
                onSubmitted: (text) {
                  phoneNo = text;
                },
              ),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///健康状况
      new GestureDetector(
        onTap: _showCheckHealDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '健康状况',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$healthLabel',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///身份类型
      new GestureDetector(
        onTap: _showIdentityTypeDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '身份类型',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$identityTypeLabel',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///最高学历
      new GestureDetector(
        onTap: _showDegreeTypeDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '最高学历',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$degreeLabel',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///公司名称
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '公司名称',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$companyName",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onSubmitted: (text) {
                  companyName = text;
                },
              ),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///客户职业信息
      new GestureDetector(
        onTap: _showCustomInfoDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '客户职业信息',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$customerInfoLabel',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///公司电话
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '公司电话',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$companyPhone",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  onSubmitted: (text) {
                    companyPhone = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///证件到期日期
      new GestureDetector(
        onTap: _showDataPicker,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '证件到期日期',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$_time',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///开户行
      new GestureDetector(
        onTap: _showBankTypeDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '开户行',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$bankName',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///银行卡类型
      new GestureDetector(
        onTap: _showBankCardTypeDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '银行卡类型',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$bankCardLabel',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///银行卡号
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '银行卡号',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$bankAccount",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  onSubmitted: (text) {
                    bankAccount = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///预留手机号
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '预留手机号',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$reservePhoneNo",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                  ],
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  onSubmitted: (text) {
                    reservePhoneNo = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///个人总收入（元/月）
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '个人总收入(元/月)',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$personalIncome",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  onSubmitted: (text) {
                    personalIncome = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///微信
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '微信',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$wxNumber",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  onSubmitted: (text) {
                    wxNumber = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///婚姻状况
      new GestureDetector(
        onTap: _showCheckMarDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '婚姻状况',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$mariLabel',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      ///借款用途
      new GestureDetector(
        onTap: _showBorrowUseDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '借款用途',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  borrowUse[borrowUseValue],
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///联系人
      new Container(
        height: 50.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('      联系人信息',
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
            ),
          ],
        ),
      ),

      ///联系人姓名
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '联系人姓名',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$contactName",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  onSubmitted: (text) {
                    if (text.isNotEmpty) {
                      contactName = text;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///联系人电话
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '联系人电话',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$contactPhone",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                  ],
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  onSubmitted: (text) {
                    contactPhone = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///联系人关系
      new GestureDetector(
        onTap: _showRelationDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '联系人关系',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$relationShipLabel',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      ///分隔阴影
      new Container(
        height: 50.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('      身份证正反面',
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
            ),
          ],
        ),
      ),

      ///身份证正反面
      new Container(
        height: 140.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new SafeArea(
                top: false,
                bottom: false,
                child: new GridView.count(
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(4.0),
                  childAspectRatio: 1.5,
                  children: idCardImageList.map((f) {
                    return new GestureDetector(
                        onTap: () {
                          var index = idCardImageList.indexOf(f);
                          if (defaultImageUrl == f) {
                            ImagePicker.pickImage(source: ImageSource.gallery)
                                .then((onValue) {
                              _uploadImage(onValue, index);
                            });
                          } else {
                            showPhoto(context, f, index);
                          }
                        },
                        child: new Container(
                          decoration: new BoxDecoration(
                            border: new Border.all(
                                width: 1.0, color: Colors.black38),
                            image: new DecorationImage(
                              image: new NetworkImage(f),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ));
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),

      ///分隔阴影
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

      ///按钮
      new Padding(
        padding: new EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  _saveUserInfo();
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                //通过控制 Text 的边距来控制控件的高度
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: new Text(
                    buttonName,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    ];

    ///_getUserInfo();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            '个人信息',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: new Center(
          child: new ListView(children: list),
        ));
  }

  /// 展示选择婚姻状况的弹窗
  _showCheckMarDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children: listViewDefault(
                      maritalList, "marital_status_flag", maritalValue)),
            ),
            /* children: listViewDefault(),*/
          );
        });
  }

  ///展示健康状况的弹窗
  void _showCheckHealDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children: listViewDefault(
                      healthList, "health_status_flag", healthValue)),
            ),
          );
        });
  }

  ///身份类型弹窗
  _showIdentityTypeDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children: listViewDefault(identityTypeList,
                      "identity_type_flag", identityTypeValue)),
            ),
          );
        });
  }

  _showDegreeTypeDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children:
                      listViewDefault(degreeList, "degree_flag", degreeValue)),
            ),
          );
        });
  }

  void _showCustomInfoDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children: listViewDefault(customerInfoList,
                      "customer_professional_info_flag", customerInfoValue)),
            ),
          );
        });
  }

  void _showBankCardTypeDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children: listViewDefault(
                      bankCardList, "bank_card_type_flag", bankCardValue)),
            ),
          );
        });
  }

  void _showBankTypeDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children: listViewDefault(
                      bankNameList, "bank_name_flag", bankNameValue)),
            ),
          );
        });
  }

  void _showBorrowUseDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children:
                      listViewDefault(borrowUse, "borrow_use", borrowUseValue)),
            ),
          );
        });
  }

  ///时间选择
  _showDataPicker() async {
    Locale myLocale = Localizations.localeOf(context);
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2099),
        locale: myLocale);
    setState(() {
      _time = picker.toString().substring(0, 10);
    });
  }

  ///联系人关系
  void _showRelationDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children: listViewDefault(relationShipList,
                      "contact_relationship_flag", relationShipValue)),
            ),
          );
        });
  }

  ///公共弹窗
  listViewDefault(List sysDictList, String type, int dataValue) {
    List<Widget> data = new List();
    if (type == "bank_name_flag") {
      for (int i = 0; i < sysDictList.length; i++) {
        data.add(
          new RadioListTile<int>(
            title: new Text(sysDictList[i]),
            value: i,
            groupValue: dataValue,
            onChanged: (int e) => updateDefaultDialogValue(e, type),
          ),
        );
      }
    } else if (type == "borrow_use") {
      for (int i = 1; i < sysDictList.length; i++) {
        data.add(
          new RadioListTile<int>(
            title: new Text(sysDictList[i]),
            value: i,
            groupValue: dataValue,
            onChanged: (int e) => updateDefaultDialogValue(e, type),
          ),
        );
      }
    } else {
      for (int i = 0; i < sysDictList.length; i++) {
        data.add(
          new RadioListTile<int>(
            title: new Text(sysDictList[i].label),
            value: int.parse(sysDictList[i].value),
            groupValue: dataValue,
            onChanged: (int e) => updateDefaultDialogValue(e, type),
          ),
        );
      }
    }

    return data;
  }

  ///公共弹窗返回值
  updateDefaultDialogValue(int e, String type) {
    Navigator.pop(context);
    setState(() {
      switch (type) {
        case 'health_status_flag':
          this.healthValue = e;
          break;
        case 'identity_type_flag':
          this.identityTypeValue = e;
          break;
        case 'degree_flag':
          this.degreeValue = e;
          break;
        case 'customer_professional_info_flag':
          this.customerInfoValue = e;
          break;
        case 'bank_card_type_flag':
          this.bankCardValue = e;
          break;
        case 'bank_name_flag':
          this.bankNameValue = e;
          break;
        case 'marital_status_flag':
          this.maritalValue = e;
          break;
        case 'contact_relationship_flag':
          this.relationShipValue = e;
          break;
        case 'borrow_use':
          this.borrowUseValue = e;
          break;
      }
    });
  }

  ///图片预览
  void showPhoto(BuildContext context, f, index) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('图片预览')),
        body: SizedBox.expand(
          child: Hero(
            tag: index,
            child: new ShowPhotoPage(url: f),
          ),
        ),
      );
    }));
  }

  Global global = Global();

  ///已存在订单时获取信息
  _getUserInfo(String bizOrderNo, int channelType, int fromPage) async {
    if (!isReload) {
      isReload = true;
      try {
        Map<String, Object> dataMap = new Map();
        List maritalStatusList = new List();
        List healthStatusList = new List();
        List identityTypeStatusList = new List();
        List degreeStatusList = new List();
        List customerInfoStatusList = new List();
        List bankCardStatusList = new List();
        List relationShipStatusList = new List();
        List bankStatusList = new List();
        List contactInfoList = new List();
        List idCraUrlList = new List();
        ClUserInfo clUserInfo;
        ClContactInfo clContactInfo;
        var borrow_usage;

        if (fromPage == 2 || fromPage == 1) {
          ///我的页面进入查看个人资料
          biz_order_no = bizOrderNo;
          if(biz_order_no == '' || biz_order_no == null){
            buttonName = "返回";
            return;
          }
          var response = await global.postFormData("user/query",
              {"biz_order_no": bizOrderNo, "channel_type": channelType});
          dataMap = response['dataMap'];
          degreeStatusList = dataMap["degree"];
          clUserInfo = ClUserInfo.fromJson(dataMap["clUserInfo"]);
          contactInfoList = dataMap["clContactInfoList"];
          clContactInfo = ClContactInfo.fromJson(contactInfoList[0]);
          Map clBaseInfo = dataMap['clBaseInfo'] as Map;
          borrow_usage = clBaseInfo['borrow_usage'];
          ///此处联系人只取一个展示
          idCraUrlList = dataMap["clAttachmentInfoList"];
          if (fromPage == 2) {
            if(widget.wxAppConfirm == 1){
              buttonName = "返回";
            }else{
              buttonName = "修改";
            }
          }
        } else {
          canWrite = true;
          ///此处openId使用 token
          openId = "token:13770207216";
          var response = await global.postFormData(
              "borrow/toBorrow/" + openId + "/" + global.DEVICE.toString());
          dataMap = response['dataMap'];
          bizOrderNo = dataMap['biz_order_no'];
          if (bizOrderNo != "" && bizOrderNo != null) {
            ///第一次进单
            biz_order_no = bizOrderNo;
          } else {
            ///非第一次进单
            clUserInfo = ClUserInfo.fromJson(dataMap["clUserInfo"]);
            biz_order_no = clUserInfo.biz_order_no;
            clContactInfo = ClContactInfo.fromJson(dataMap["clContactInfo"]);
            idCraUrlList = dataMap["attachmentInfoList"];
            Map riskData = dataMap['clBaseInfo'] as Map;
            borrow_usage = riskData['borrow_usage'].toString();
          }
          degreeStatusList = dataMap["degreeS"];
        }

        ///此处为公用的选择框数据
        maritalStatusList = dataMap["marital_status"];
        healthStatusList = dataMap["health"];
        identityTypeStatusList = dataMap["identity_type"];
        customerInfoStatusList = dataMap["customerInfo"];
        bankCardStatusList = dataMap["bankCards"];
        relationShipStatusList = dataMap["relationShip"];
        bankStatusList = dataMap["bank_list"];

        setState(() {
          if (clUserInfo != null) {
            userName = clUserInfo.user_name;
            idCard = clUserInfo.idcard;
            idCardAddress = clUserInfo.idcard_address;
            residentialAddress = clUserInfo.residential_address;
            phoneNo = clUserInfo.phone_no;
            companyName = clUserInfo.company_name;
            companyPhone = clUserInfo.company_phone_no;
            wxNumber = clUserInfo.wechat;
            personalIncome = clUserInfo.personal_income.toString();
            bankAccount = clUserInfo.bank_account;
            reservePhoneNo = clUserInfo.reserve_phone_no;
            bankName = clUserInfo.bank_name;
            _time = clUserInfo.certificate_expiry_date;

            maritalValue = int.parse(clUserInfo.marital_status);
            healthValue = int.parse(clUserInfo.health_status);
            identityTypeValue = int.parse(clUserInfo.identity_type);
            degreeValue = int.parse(clUserInfo.degree);
            customerInfoValue =
                int.parse(clUserInfo.customer_professional_info);
            bankCardValue = int.parse(clUserInfo.bank_card_type);
            borrowUseValue = int.parse(borrow_usage);
            borrowUseLabel = borrowUse[borrowUseValue];
          }

          if (clContactInfo != null) {
            contactName = clContactInfo.contactName;
            contactPhone = clContactInfo.contactPhone;
            relationShipValue = int.parse(clContactInfo.contactRelationship);
          }

          bankNameList = bankStatusList;

          ///婚姻状况
          List<SysDict> maritalLists = new List();
          for (int i = 0; i < maritalStatusList.length; i++) {
            SysDict sysDict = new SysDict();
            sysDict.value = maritalStatusList[i]["value"];
            sysDict.label = maritalStatusList[i]["label"];
            maritalLists.add(sysDict);
          }
          maritalList = maritalLists;

          ///健康状况
          List<SysDict> healthLists = new List();
          for (int i = 0; i < healthStatusList.length; i++) {
            SysDict sysDict = new SysDict();
            sysDict.value = healthStatusList[i]["value"];
            sysDict.label = healthStatusList[i]["label"];
            healthLists.add(sysDict);
          }
          healthList = healthLists;

          ///身份类型
          List<SysDict> identityTypes = new List();
          for (int i = 0; i < identityTypeStatusList.length; i++) {
            SysDict sysDict = new SysDict();
            sysDict.value = identityTypeStatusList[i]["value"];
            sysDict.label = identityTypeStatusList[i]["label"];
            identityTypes.add(sysDict);
          }
          identityTypeList = identityTypes;

          ///最高学历
          List<SysDict> degreeLists = new List();
          for (int i = 0; i < degreeStatusList.length; i++) {
            SysDict sysDict = new SysDict();
            sysDict.value = degreeStatusList[i]["value"];
            sysDict.label = degreeStatusList[i]["label"];
            degreeLists.add(sysDict);
          }
          degreeList = degreeLists;

          ///银行卡类型
          List<SysDict> bankCards = new List();
          for (int i = 0; i < bankCardStatusList.length; i++) {
            SysDict sysDict = new SysDict();
            sysDict.value = bankCardStatusList[i]["value"];
            sysDict.label = bankCardStatusList[i]["label"];
            bankCards.add(sysDict);
          }
          bankCardList = bankCards;

          ///客户职业信息
          List<SysDict> customerInfos = new List();
          for (int i = 0; i < customerInfoStatusList.length; i++) {
            SysDict sysDict = new SysDict();
            sysDict.value = customerInfoStatusList[i]["value"];
            sysDict.label = customerInfoStatusList[i]["label"];
            customerInfos.add(sysDict);
          }
          customerInfoList = customerInfos;

          ///联系人关系
          List<SysDict> relationShips = new List();
          for (int i = 0; i < relationShipStatusList.length; i++) {
            SysDict sysDict = new SysDict();
            sysDict.value = relationShipStatusList[i]["value"];
            sysDict.label = relationShipStatusList[i]["label"];
            relationShips.add(sysDict);
          }
          relationShipList = relationShips;

          ///身份证
          if (idCraUrlList.length > 0) {
            for (int i = 0; i < idCraUrlList.length; i++) {
              String filePath = idCraUrlList[i]["file_path"];
              idCardImageList.add(filePath);
            }
          } else {
            for (int i = 0; i < 2; i++) {
              idCardImageList.add(defaultImageUrl);
            }
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  ///信息保存
  Future _saveUserInfo() async {

    if(widget.wxAppConfirm == 1 || biz_order_no == null){
      Navigator.of(context).pop();
      return;
    }

    if (userName.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "真实姓名不能为空", null);
      return;
    }

    if (idCard.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "身份证不能为空", null);
      return;
    }

    if (idCardAddress.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "身份证地址不能为空", null);
      return;
    }

    if (residentialAddress.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "现居住地址不能为空", null);
      return;
    }

    if (phoneNo.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "手机号码不能为空", null);
      return;
    }

    if (healthLabel.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "健康状况不能为空", null);
      return;
    }

    if (identityTypeLabel.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "身份类型不能为空", null);
      return;
    }

    if (degreeLabel.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "最高学历不能为空", null);
      return;
    }

    if (companyName.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "公司名不能为空", null);
      return;
    }

    if (customerInfoLabel.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "客户职业信息不能为空", null);
      return;
    }

    if (companyPhone.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "公司号码不能为空", null);
      return;
    }

    if (bankCardLabel.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "银行卡类型不能为空", null);
      return;
    }

    if (bankAccount.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "银行卡号不能为空", null);
      return;
    }

    if (reservePhoneNo.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "预留手机号不能为空", null);
      return;
    }

    if (personalIncome.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "个人收入不能为空", null);
      return;
    }

    if (wxNumber.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "微信号码不能为空", null);
      return;
    }

    if (mariLabel.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "婚姻状况不能为空", null);
      return;
    }

    if (contactName.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "联系人姓名不能为空", null);
      return;
    }

    if (contactPhone.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "联系人手机号码不能为空", null);
      return;
    }

    if (relationShipLabel.isEmpty) {
      DialogUtils.showAlertDialog(context, "提示", "联系人关系不能为空", null);
      return;
    }

    if (idCardImageList.contains(defaultImageUrl)) {
      DialogUtils.showAlertDialog(context, "提示", "请上传身份证正反面", null);
      return;
    }

    if (borrowUseValue <= 0) {
      DialogUtils.showAlertDialog(context, "提示", "请选择贷款用途", null);
      return;
    }

    String url = "user/save";
    if (widget.fromPage == 0) {
      url = "borrow/saveUserInfo";
    }

    try {
      var response = await global.postFormData(url, {
        "data": {
          "openid": "token:13770207216",
          "channel_type": widget.channelType,
          "biz_order_no": biz_order_no,
          "user_name": userName,
          "idcard": idCard,
          "idcard_address": idCardAddress,
          "residential_address": residentialAddress,
          "phone_no": phoneNo,
          "health_status": healthValue,
          "identity_type": identityTypeValue,
          "degree": degreeValue,
          "company_name": companyName,
          "customer_professional_info": customerInfoValue,
          "company_phone_no": companyPhone,
          "certificate_expiry_date": _time,
          "bank_name": bankNameValue,
          "bank_card_type": bankCardValue,
          "bank_account": bankAccount,
          "reserve_phone_no": reservePhoneNo,
          "personal_income": personalIncome,
          "wechat": wxNumber,
          "marital_status": maritalValue,
          "contact_name": contactName,
          "contact_phone": contactPhone,
          "contact_relationship": relationShipValue,
          "borrow_usage" : borrowUseValue
        },
      });

      if (response["code"] == 0) {
        global.user.idCard = idCard;
        ///如果是从我的页面进入就弹出修改成功的提示框
        if (widget.fromPage == 2) {
          DialogUtils.showAlertDialog(context, "提示", "修改成功", null);
        } else {
          ///跳转到车辆信息页面
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return CarInfoPage(
              bizOrderNo: biz_order_no,
              channelType: widget.channelType,
              fromPage: widget.fromPage,
            );
          }));
        }
      }
    } catch (e) {
      print(e);
      DialogUtils.showAlertDialog(context, "提示", "保存失败", null);
    }
  }

  ///图片上传公用方法
  void _uploadImage(File imageFile, int index) async {
    String fileType = "1";
    FormData formData = new FormData.from({
      "biz_order_no": biz_order_no,
      "file_type": fileType,
      "formType": formType,
    });
    if (imageFile != null) {
      formData.add("file", new UploadFileInfo(imageFile, "身份证正反面.png"));
    }
    var response =
        await global.postFormData("attachmentInfo/uploadFile", formData);
    DataResponse dataResponse = DataResponse.fromJson(response);
    Map<String, Object> map = dataResponse.entity as Map;
    String filePath = map['file_path'];
    setState(() {
      idCardImageList[index] = filePath;
    });
  }
}
