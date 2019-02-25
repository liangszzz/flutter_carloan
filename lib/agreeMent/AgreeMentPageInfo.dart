import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';

class AgreementInfoPage extends StatefulWidget {
  final String title;
  final String bizOrderNo;

  ///1 表示正式表 2 表示微信表
  final int channelType;

  const AgreementInfoPage({Key key, this.title, this.channelType, this.bizOrderNo}) : super(key: key);

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
      var response = await global.postFormData("agreement/query/"+widget.bizOrderNo + "/" + widget.channelType.toString());
      content = response["msg"];
      setState(() {
        htmlInfo = content;
      });
    }
  }
}
