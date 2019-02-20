import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/message/Message.dart';

class MyMessage extends StatefulWidget {

  final String phone;

  const MyMessage({Key key, this.phone}) : super(key: key);

  @override
  _ListViewDemoState createState() => new _ListViewDemoState();
}

class _ListViewDemoState extends State<MyMessage> {
  List lists = new List();
  bool isReload = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getMessage(widget.phone);

    return Scaffold(
        appBar: AppBar(title: Text('我的消息'), elevation: 0.5),
        body: listViewDefault(lists));
  }

  ///默认构建
  Widget listViewDefault(List list) {
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
              list[i].content,
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            new Align(
              alignment: Alignment.centerRight,
              child: new Text(list[i].createTime),
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

  Global global = Global();
  _getMessage(String phone) async {
    if (!isReload) {
      isReload = true;
      try {
        List data = new List();
        await Dio().post("http://192.168.1.13:8081/message/query", data: {
          "phone": phone,
          "page": 1,
          "size": 5
        }).then((response) {
          data = response.data['data'];
        });
        setState(() {
          List<Message> list = new List();
          for (int i = 0; i < data.length; i++) {
            Message message = new Message();
            message.content = data[i]['content'];
            message.createTime = data[i]['create_time'];
            list.add(message);
          }
          lists = list;
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
