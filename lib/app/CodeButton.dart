import 'dart:async';

import 'package:flutter/material.dart';

class CodeButton extends StatefulWidget {
  final second = 60;

  final VoidCallback callback;

  const CodeButton({Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CodeButtonState();
}

class _CodeButtonState extends State<CodeButton> {
  Timer timer;

  int _second = 0;

  @override
  Widget build(BuildContext context) {
    if (_second > 0) {
      return Container(
        width: 95,
        alignment: Alignment.center,
        child: Text(
          "${_second}",
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      );
    }
    return GestureDetector(
      onTap: _onPress,
      child: Container(
        child: Text(
          "获取验证码",
          style: TextStyle(fontSize: 14, color: Colors.green),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _onPress() {
    setState(() {
      _second = this.widget.second;
    });
    _secondUpdate();
    this.widget.callback();
  }

  void _secondUpdate() {
    timer = Timer(Duration(seconds: 1), () {
      setState(() {
        --_second;
      });
      _secondUpdate();
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
