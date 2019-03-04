import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  ///弹出一个 只有 [确定] 的提示框
  static void showAlertDialog(
      BuildContext context, String title, String content, VoidCallback callback,
      {TextStyle titleStyle,
      TextStyle contentStyle,
      String btnText = "确定",
      TextStyle btnTextStyle}) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: Text(title, style: titleStyle),
            content: Text(content, style: contentStyle),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    if (callback != null) callback();
                    Navigator.pop(context);
                  },
                  child: new Text(
                    btnText,
                    style: btnTextStyle,
                  ))
            ],
          );
        });
  }

  ///弹出一个 有 [确定,取消] 的提示框
  static void showConfirmDialog(BuildContext context, String title,
      String content, VoidCallback callbackOne, VoidCallback callbackTwo,
      {TextStyle titleStyle,
      TextStyle contentStyle,
      String btnTextOne = "确定",
      String btnTextTwo = "取消",
      TextStyle btnTextStyle}) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: Text(title, style: titleStyle),
            content: Text(content, style: contentStyle),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    if (callbackOne != null) callbackOne();
                    Navigator.pop(context);
                  },
                  child: new Text(
                    btnTextOne,
                    style: btnTextStyle,
                  )),
              FlatButton(
                  onPressed: () {
                    if (callbackTwo != null) callbackTwo();
                    Navigator.pop(context);
                  },
                  child: new Text(
                    btnTextTwo,
                    style: btnTextStyle,
                  ))
            ],
          );
        });
  }

  ///无按钮弹窗
  static void showNoBtnDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (context) {
        AlertDialog(
          content: Text(msg),
        );
      },
    );
  }

  ///自动关闭的无按钮弹窗
  static void showAutoCloseNoBtnDialog(
      BuildContext context, String msg,
      {VoidCallback callback,Duration duration = const Duration(seconds: 2)}) {
    showDialog(
      context: context,
      builder: (context) => AutoDialogWidget(
            duration: duration,
            callback: callback,
            dialogWidget: AlertDialog(content: Text(msg)),
          ),
    );
  }

  ///自动关闭的Loading弹窗
  static void showLoadingDialog(BuildContext context,
      {VoidCallback callback,Duration duration = const Duration(seconds: 2)}) {
    showDialog(
      context: context,
      builder: (context) => AutoDialogWidget(
            duration: duration,
            callback: callback,
            dialogWidget: CupertinoActivityIndicator(),
          ),
    );
  }
}

class AutoDialogWidget extends StatefulWidget {
  final Duration duration;

  final VoidCallback callback;

  final Widget dialogWidget;

  AutoDialogWidget(
      {Key key,
      this.duration,
      this.callback,
      this.dialogWidget})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AutoDialogWidgetState();
}

class _AutoDialogWidgetState extends State<AutoDialogWidget> {
  Timer timer;

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timer = new Timer(this.widget.duration, () {
      Navigator.of(context).pop(this.widget.dialogWidget);
      if (this.widget.callback != null) this.widget.callback();
    });

    return this.widget.dialogWidget;
  }
}
