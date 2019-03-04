import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;

  final VoidCallback onClick;

  final Color btnBackGround;

  const CommonButton({Key key, this.text, this.onClick, this.btnBackGround=Colors.blue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle = TextStyle(fontSize: 16, color: Colors.white);
    return Row(
      children: <Widget>[
        Expanded(
            child: FlatButton(
                onPressed: onClick,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: btnBackGround,
                child: Text(
                  text,
                  style: buttonStyle,
                )))
      ],
    );
  }
}
