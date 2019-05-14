import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carloan/app/Global.dart';
import 'package:flutter_carloan/common/DialogUtils.dart';

class updateVersionPage extends StatefulWidget {
  updateVersionPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _updateVersionPageState createState() => new _updateVersionPageState();
}

class _updateVersionPageState extends State<updateVersionPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  bool showing = false;
  bool first = true;

  Global global = Global();

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    animation = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      })
      ..addListener(() {
        if (!showing) {
          setState(() {});
        }
        //  setState(() {});
      });
    animationController.repeat();
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(updateVersionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      Future.delayed(Duration.zero, () => showAlertDialog(context));
      first = false;
    }

    return WillPopScope(
      onWillPop: () {
        ///提示是否退出
        DialogUtils.showConfirmDialog(context, "确认要退出应用吗?", "", () {
          exit(0);
        }, null);
      },
      child: Scaffold(
          appBar: AppBar(
            title: new Text("车贷系统更新"),
            elevation: 0,
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
          )),
    );

  }

  void showAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 10.0),
                  //width: 100,
                  height: 35,
                  child: Text('版本更新',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
                SizedBox(height: 20),
                Text("版本号 ： v1.0.0 -> v1.0.1"),
                SizedBox(height: 3),
                Text("更新内容 ："),
                SizedBox(height: 3),
                Text("  1.修改部分bug"),
                Text("  2.页面样式优化"),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          actions: <Widget>[
            new WillPopScope(
                onWillPop: () {
                  return Future.value(false);
                },
                child: new Container(
                  width: 250,
                  child: _create(),
                ),
            )
          ], // 圆角
        );
      },
    );
  }

  Row _create() {
    //已读
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child:
              Text('确认', style: TextStyle(fontSize: 16, color: Colors.blue)),
          //可点击
          color: Theme.of(context).primaryColor,
          onPressed: () {
            _download();
          },
        ),
        FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child:
          Text('取消', style: TextStyle(fontSize: 16, color: Colors.blue)),
          //可点击
          color: Theme.of(context).primaryColor,
          onPressed: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
        ),
        SizedBox(
          width: 10.0,
        )
      ],
    );
  }

  Future _download() async {
    var url = "/app/update";
    var response = await global.post(url);
  }
}
