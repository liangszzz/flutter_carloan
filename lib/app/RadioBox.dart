import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';

class RadioBoxless extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new RadioBox();
  }
}

class RadioBox extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<RadioBox> {


  int radioValue = 0;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      print(value);
    });
  }

  Global global = Global();
  _getDict() async {
    var response = await global.post("user/getRecentOrder/320925199011273112");
    DataResponse d = DataResponse.fromJson(json.decode(response));
    setState(() {
      if (d.success()) {
        Map<String, Object> map = d.entity as Map;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _getDict();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("通用选择器"),
      ),
      body: new Center(
          child: new Column(
        children: <Widget>[
          new RadioListTile(
              value: 0,
              title: new Text("张三"),
              groupValue: radioValue,
              onChanged: handleRadioValueChanged),
          new RadioListTile(
              value: 1,
              title: new Text("李四"),
              groupValue: radioValue,
              onChanged: handleRadioValueChanged),
          new RadioListTile(
              value: 2,
              title: new Text("王五"),
              groupValue: radioValue,
              onChanged: handleRadioValueChanged),
          new RadioListTile(
              value: 3,
              title: new Text("赵六"),
              groupValue: radioValue,
              onChanged: handleRadioValueChanged),
        ],
      )),
    );
  }
}
