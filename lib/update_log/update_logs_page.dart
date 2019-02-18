import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_carloan/update_log/update_log.dart';

// ignore: must_be_immutable
class UpdateLogsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UpdateLogsPageState();
  }
}

class UpdateLogsPageState extends State<UpdateLogsPage> {
  List logs = new List();

  // 是否通过http查询过后台
  bool loaded = false;

  _getHttp() async {
    try {
      List data = new List();
      await Dio()
          .post("http://192.168.1.3:8081/updateLog/query")
          .then((response) {
        data = response.data['data'];
      });

      setState(() {
        List<UpdateLog> list = new List();
        for (int i = 0; i < data.length; i++) {
          UpdateLog log = new UpdateLog();
          log.update_title = data[i]['update_title'];
          log.create_time = data[i]['create_time'];
          list.add(log);
        }
        logs = list;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 只查询一次
    if (loaded == false) {
      loaded = true;
      _getHttp();
    }

    return new Container(
        decoration:
            new BoxDecoration(color: new Color.fromARGB(1, 234, 234, 234)),
        child: new Container(child: ListView.builder(
          itemBuilder: (context, i) {

            // 没有日志的情况
            if (logs == null || logs.length == 0) {
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
            if (index < logs.length) {
              return new Container(
                padding: const EdgeInsets.all(16.0),
                decoration: new BoxDecoration(color: Colors.white),
                child: Column(
                  children: <Widget>[
                    new Text(
                      logs[index].update_title,
                      style: new TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    new Container(
                      child: new Text(
                        logs[index].create_time,
                      ),
                      margin: EdgeInsets.only(top: 10.0),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              );
            }

          },
        )));
  }
}
