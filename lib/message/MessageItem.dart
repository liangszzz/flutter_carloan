import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/Message.dart';

class MyMessage extends StatefulWidget {
  @override
  _ListViewDemoState createState() => new _ListViewDemoState();
}

class _ListViewDemoState extends State<MyMessage> {
  List<Message> list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = new List<Message>.generate(
        10,
        (i) => new Message(
            "name$i", 'i', "content=$i", "name$i", "i", "content=$i"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('我的消息'), elevation: 0.5),
        body: listViewDefault(list));
  }

  ///默认构建
  Widget listViewDefault(List<Message> list) {
    List<Widget> _list = new List();
    for (int i = 0; i < list.length; i++) {
      _list.add(new Container(
        height: 120,
        decoration: new BoxDecoration(
          color: Colors.black12,
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text(
              "您提交的40000元借款申请已经审核通过了，请尽快核实个人信息并提交",
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            new Align(
              alignment: Alignment.centerRight,
              child: const Text('2019-02-13 12:00:00'),
            )
          ],
        ),
      ));
    }

// 添加分割线
    var divideList =
        ListTile.divideTiles(context: context, tiles: _list).toList();
    return new Scrollbar(
      child: new ListView(
        // 添加ListView控件
        children: divideList, // 添加分割线/
      ),
    );
  }
}
