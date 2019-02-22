import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';

class HtmlInfoPage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<HtmlInfoPage> {
  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  String lorem ="";

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {}

  bool isReload = false;

  @override
  Widget build(BuildContext context) {


    _getAgree();


    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new SingleChildScrollView(
          child: new Center(
            child: new HtmlTextView(
              data: lorem,
            ),
          ),
        ),
      ),
    );
  }

  Future _getAgree() async {
    if(!isReload){
      isReload = true;
      String content = "";
      await Dio().post("http://192.168.1.13:8081/agreement/query/QSM20190222111810and/1").then((response) {
        content = response.data["msg"];
      });
      setState(() {
        lorem = content;
      });
    }
  }
}

