import 'package:flutter/material.dart';

class UserInfoCell extends StatelessWidget {
  final VoidCallback onPressed;
  final String keyName;
  final String valueName;
  final String imgSrc;

  UserInfoCell({this.valueName, this.keyName, this.onPressed, this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Text(keyName, style: TextStyle(fontSize: 18)),
                  SizedBox(width: 30),
                  Text(valueName, style: TextStyle(fontSize: 18)),
                  Expanded(child: Container()),
                  Image.asset(imgSrc),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
              margin: EdgeInsets.only(left: 0),
            ),
          ],
        ),
      ),
    );
  }
}
