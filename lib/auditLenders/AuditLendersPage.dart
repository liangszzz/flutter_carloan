import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/DataResponse.dart';
import 'package:flutter_carloan/common/CommonButton.dart';
import 'package:flutter_carloan/common/DialogUtils.dart';
import 'package:flutter_carloan/index/RootScene.dart';
import 'package:flutter_carloan/app/Global.dart';

///审核放款页面
class AuditLendersPage extends StatefulWidget {
  final String bizOrderNo;

  final int channelType;

  const AuditLendersPage({Key key, this.bizOrderNo, this.channelType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuditLendersState();
}

class _AuditLendersState extends State<AuditLendersPage> {
  Global global = new Global();

  ///页面名称
  String pageName = "审核放款中";

  ///页面标题下的内容
  String pageContent = "";

  ///借款金额
  double applyAmount = 4000;

  ///每期应还
  double shouldPayPer = 1000;

  ///末期应还
  double shouldPayLast = 1000;

  ///期数
  String repaymentTerms = "4";

  ///提交日期
  String submitDate = "2018-01-01";

  ///末期还款日期
  String shouldPayLastDate = "2018-05-01";

  ///还款方式
  String repaymentMethod = "等额本息";

  ///还款方式 值
  String repaymentMethodValue = "1";

  ///银行卡信息
  String bankInfo = "中国银行(尾号0011)";

  Timer timer;

  double containerHeight = 36.0;

  @override
  void initState() {
    onLoad();
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  void onLoad() async {
    var response = await global.post(
        "baseInfo/detail/${this.widget.bizOrderNo}/${this.widget.channelType}");
    var d = DataResponse.fromJson(response);
    if (d.success()) {
      var data = d.dataMap;
      setState(() {
        pageName = data['page_name'];
        pageContent = data['page_content'];
        applyAmount = data['apply_amount'];
        if (data['should_pay_per'] == 0)
          shouldPayPer = 0;
        else
          shouldPayPer = data['should_pay_per'];
        shouldPayLast = data['should_pay_last'];
        repaymentTerms = data['repayment_terms'];
        submitDate = data['submit_date'];
        shouldPayLastDate = data['should_pay_last_date'];
        repaymentMethod = data['repayment_method'];
        shouldPayLastDate = data['should_pay_last_date'];
        repaymentMethodValue = data['repayment_method_value'];
        bankInfo = data['bank_info'];
      });
    } else {
      DialogUtils.showAlertDialog(context, "提示", "获取信息失败!", () {
        timer = Timer(Duration(seconds: 3), () {
          onLoad();
        });
      }, contentStyle: TextStyle(color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _buildTitle(),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: _buildBody(),
        ),
      ));

  _buildTitle() {
    return Text("订单详情");
  }

  _buildBody() {
    var btn = CommonButton(text: "确定", onClick: _doCheck);
    List<Widget> list = <Widget>[
      Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/images/alarmClock.png"),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    pageName,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '审核通过后会通过短信或微信通知您，',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '请耐心等候',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      new Container(
        height: 30.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('',
                  style: TextStyle(
                      fontSize: 12.0, color: const Color(0xffAAAAAA))),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '订单信息',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: containerHeight,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '借款金额',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                '$applyAmount元',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: containerHeight,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '每期应还',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                repaymentMethodValue == '1'
                    ? "每期应还$shouldPayPer元(共" + repaymentTerms + "期)"
                    : ("末期金额:$shouldPayLast元"),
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: containerHeight,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '提交日期',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                '$submitDate',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: containerHeight,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '预计到期时间',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                '$shouldPayLastDate',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: containerHeight,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '还款方式',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                '$repaymentMethod',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: containerHeight,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '借款银行卡',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                '$bankInfo',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: containerHeight,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '由大兴安岭农商银行提供贷款服务',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 45.0, 20.0, 0.0),
        height: containerHeight,
        child: new Row(
          children: <Widget>[
            new Expanded(child: btn),
          ],
        ),
      ),
    ];
    return list;
  }

  void _doCheck() {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => RootScene()),
        (route) => route == null);
  }
}
