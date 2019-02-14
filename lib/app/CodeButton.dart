import 'package:flutter/material.dart';

class CodeButton extends StatelessWidget {
  ///点击回调
  final VoidCallback onPress;

  ///倒计时
  final int second;

  const CodeButton({Key key, this.onPress, this.second}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (second > 0) {
      return Container(
        width: 95,
        alignment: Alignment.center,
        child: Text(
          '${second}',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      );
    }
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Text(
          "获取验证码",
          style: TextStyle(fontSize: 14, color: Colors.green),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
