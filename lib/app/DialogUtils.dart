import 'package:flutter/material.dart';

class DialogUtils {
  ///alertDialog
  static void showAlertDialog(
      BuildContext context, String title, String content, VoidCallback callback,
      {TextStyle titleStyle,
      TextStyle contentStyle,
      String btnText = "确定",
      TextStyle btnTextStyle}) {
    showDialog(
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
}
