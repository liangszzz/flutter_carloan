import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/Global.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';

class AgreementInfoPage extends StatefulWidget {
  final String title;
  final String bizOrderNo;

  ///1 表示正式表 2 表示微信表
  final int channelType;

  ///以下针对借款合同页面 需要参数
  ///申请金额
  final String applyAmount;

  ///期数
  final String terms;

  ///还款方式
  final String method;

  const AgreementInfoPage(
      {Key key,
      this.title,
      this.bizOrderNo,
      this.channelType,
      this.applyAmount,
      this.terms,
      this.method})
      : super(key: key);

  ///查询表 1：微信表 其余：正式表

  @override
  _AgreementInfoState createState() => new _AgreementInfoState();
}

class _AgreementInfoState extends State<AgreementInfoPage> {
  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  String htmlInfo = "";

  initPlatformState() async {}

  bool isReload = false;

  @override
  Widget build(BuildContext context) {
    _getAgree();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new HtmlTextView(
            data: htmlInfo,
          ),
        ),
      ),
    );
  }

  Global global = Global();
  Future _getAgree() async {
    if (!isReload) {
      isReload = true;
      String content = "";
      var response;
      if (widget.applyAmount != null && widget.applyAmount != '') {
        FormData formData = new FormData.from({
          "biz_order_no": widget.bizOrderNo,
          "repaymentTerms": widget.terms,
          "repayment_method" : widget.method,
          "page_type" : widget.channelType,
          "apply_amount" : widget.applyAmount
        });
        response = await global.postFormData("agreement/queryAgreement", formData);
      }else{
        var queryUrl = "agreement/query/" +
            widget.bizOrderNo +
            "/" +
            widget.channelType.toString();
        response = await global.postFormData(queryUrl);
      }
      content = response["msg"];
      setState(() {
        htmlInfo = content;
      });
    }
  }
}
