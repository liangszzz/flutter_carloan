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
  bool isReloadMore = false;

  var currentPage = 1;
  var size = 7;

  ///一个页面显示7条数据

  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        currentPage = currentPage + 1;
        _getMoreMessage(currentPage, size, widget.phone);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getMessage(currentPage, size, widget.phone);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '我的消息',
            style: TextStyle(fontSize: 16),
          ),
          elevation: 0.5,
          centerTitle: true,
        ),
        body: listViewDefault(lists));
  }

  ///默认构建
  Widget listViewDefault(List list) {
    List<Widget> _list = new List();
    for (int i = 0; i < list.length; i++) {
      _list.add(new Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0),
        decoration: new BoxDecoration(
          color: Colors.white10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              height: 60,
              alignment: Alignment.centerLeft,
              child: new Text(
                list[i].content,
                style: new TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            new Container(
              height: 22,
              alignment: Alignment.centerLeft,
              child: new Text(
                list[i].createTime,
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
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
        controller: _scrollController,
      ),
    );
  }

  Global global = Global();
  _getMessage(int currentPage, int size, String phone) async {
    if (!isReload) {
      isReload = true;
      try {
        List data = new List();
        var response = await global.postFormData("message/query",
            {"phone": phone, "page": currentPage, "size": size});
        data = response["data"];
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

  ///加载更多
  _getMoreMessage(int currentPage, int size, String phone) async {
    if (!isReloadMore) {
      try {
        List data = new List();
        var response = await global.postFormData("message/query",
            {"phone": phone, "page": currentPage, "size": size});
        data = response["data"];
        if (data.length == 0) {
          ///没有数据了
          isReloadMore = true;
        }
        setState(() {
          List<Message> list = new List();
          for (int i = 0; i < data.length; i++) {
            Message message = new Message();
            message.content = data[i]['content'];
            message.createTime = data[i]['create_time'];
            list.add(message);
          }
          lists.addAll(list);
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
