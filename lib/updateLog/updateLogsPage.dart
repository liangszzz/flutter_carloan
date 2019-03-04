import 'package:flutter/material.dart';
import 'package:flutter_carloan/updateLog/updateLog.dart';

import 'package:flutter_carloan/common/Global.dart';

// ignore: must_be_immutable
class UpdateLogsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UpdateLogsPageState();
  }
}

class UpdateLogsPageState extends State<UpdateLogsPage> {
  // 更新日志列表
  List<UpdateLog> _logs = new List();

  // 是否通过http查询过后台
  bool _loaded = false;

  // 请求地址
  String _requestPath = "updateLog/query";
  Global _global = new Global();

  // 灰色
  static Color _greyColor = Color.fromRGBO(234, 234, 234, 1);

  // 黑色
  static Color _blackColor = Color.fromRGBO(16, 16, 16, 1);

  // 白色
  Color _whiteColor = Color.fromRGBO(255, 255, 255, 1);

  // 浅黑色
  Color _lightBlackColor = Color.fromRGBO(94, 94, 94, 1);

  // arial字体
  String _arial = 'Arial';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "更新日志",
          style: new TextStyle(
            fontFamily: _arial,
            fontSize: 16,
            color: _blackColor,
          ),
        ),
      ),
      body: new Container(
        color: _greyColor,
        child: _getList(),
      ),
    );
  }

  Widget _getList() {
    // 只查询一次
    if (_loaded == false) {
      _getData();
    }
    return new Container(
      color: _greyColor,
      child: ListView.builder(
        itemBuilder: (context, i) {
          // 没有日志的情况
          if (_logs == null || _logs.length == 0) {
            return null;
          }

          // i为奇数时创建一个Container当作分割线
          if (i.isOdd) {
            return new Container(
              height: 3,
            );
          }

          // i除以2取整，得到实际内容的条数
          final index = i ~/ 2;

          // 内容没展示完全时继续生成组件
          if (index < _logs.length) {
            String updateDate;
            String createTime = _logs[index].createTime;
            if (createTime != null) {
              int length = createTime.length;
              updateDate = createTime.substring(0, length - 2);
            }
            return new Container(
              padding:
                  EdgeInsets.only(left: 32, right: 29, top: 22, bottom: 13),
              color: _whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      _logs[index].updateTitle,
                      style: new TextStyle(
                        fontSize: 14,
                        color: _lightBlackColor,
                        fontFamily: _arial,
                      ),
                    ),
                  ),
                  new Container(
                    height: 22,
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      updateDate,
                      style: TextStyle(
                        color: _lightBlackColor,
                        fontSize: 10,
                        fontFamily: _arial,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  _getData() async {
    try {
      Map response = await _global.post(_requestPath);
      List data = new List();
      data = response['data'];
      _logs = new List();

      for (int i = 0; i < data.length; i++) {
        UpdateLog log = new UpdateLog();
        log.updateTitle = data[i]['update_title'];
        log.createTime = data[i]['create_time'];
        _logs.add(log);
      }

      setState(() {
        _loaded = true;
      });
    } catch (e) {
      print(e);
    }
  }
}
