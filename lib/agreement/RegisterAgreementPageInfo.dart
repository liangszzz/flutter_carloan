import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/Global.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';

class RegisterAgreementInfoPage extends StatefulWidget {
  final String title;
  final String requestUrl;

  const RegisterAgreementInfoPage({Key key, this.title, this.requestUrl}) : super(key: key);

  @override
  _RegisterAgreementInfoState createState() =>
      new _RegisterAgreementInfoState();
}

class _RegisterAgreementInfoState extends State<RegisterAgreementInfoPage> {
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
      response = await global.postFormData(widget.requestUrl);
      content = response["msg"];
      setState(() {
        htmlInfo = content;
      });
    }
  }
}
