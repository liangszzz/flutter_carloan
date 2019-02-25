import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/DialogUtils.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';

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
  String applyAmount = "4000";

  ///每期应还
  String shouldPayPer = "1000";

  ///末期应还
  String shouldPayLast = "1000";

  ///期数
  String repaymentTerms = "4";

  ///提交日期
  String submitDate = "2018-01-01";

  ///末期还款日期
  String shouldPayLastDate = "2018-05-01";

  ///还款方式
  String repaymentMethod = "等额本息";

  ///还款方式 值
  int repaymentMethodValue = 1;

  ///银行卡信息
  String bankInfo = "中国银行(尾号0011)";

  @override
  void initState() {
    super.initState();
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
        Timer timer = Timer(Duration(seconds: 3), () {
          onLoad();
        });
      }, contentStyle: TextStyle(color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: _buildBody(),
      ));

  _buildTitle() {
    return Text(pageName, style: TextStyle(fontSize: 14));
  }

  _buildBody() {
    var btn = FlatButton(
        onPressed: _doCheck,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: Colors.green,
        child: Text(
          "确定",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ));

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/alarmClock.png"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text("订单信息", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            Text("借款金额:"+applyAmount + "元"),
            SizedBox(
              height: 5,
            ),
            repaymentMethodValue == 1
                ? Text("每期应还:" + shouldPayPer + "元(共" + repaymentTerms + ")期")
                : Text("末期金额:" + shouldPayLast + "元"),
            SizedBox(
              height: 5,
            ),
            Text("提交日期:" + submitDate),
            SizedBox(
              height: 5,
            ),
            Text("预计到期时间:" + shouldPayLastDate),
            SizedBox(
              height: 5,
            ),
            Text("还款方式:" + repaymentMethod),
            SizedBox(
              height: 5,
            ),
            Text("借款银行卡:" + bankInfo),
            SizedBox(
              height: 5,
            ),
            Text("由大兴安岭农商银行提供贷款服务",style: TextStyle(color: Colors.green,fontSize: 20),),

            SizedBox(
              height: 20,
            ),
            btn
          ],
        ));
  }

  void _doCheck() {

  }
}
