import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/Global.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';

class PersonalAgreementInfoPage extends StatefulWidget {

  final String idCard;

  const PersonalAgreementInfoPage({Key key, this.idCard}) : super(key: key);

  @override
  _PersonalAgreementInfoState createState() =>
      new _PersonalAgreementInfoState();
}

class _PersonalAgreementInfoState extends State<PersonalAgreementInfoPage> {
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
        title: new Text("个人信息授权协议"),
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
      FormData formData = new FormData.from({
        "idcard": widget.idCard,
      });
      var response = await global.postFormData("agreement/personalInfo", formData);
      String content = response["msg"];
      setState(() {
        htmlInfo = content;
      });
    }
  }
}
