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
}
