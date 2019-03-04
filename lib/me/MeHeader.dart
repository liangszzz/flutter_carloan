import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/Global.dart';

class MeHeader extends StatefulWidget {
  final String applyAmount;

  const MeHeader({Key key, this.applyAmount}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHeaderPage();
  }
}

class MyHeaderPage extends State<MeHeader> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: Container(
        color: Colors.blueAccent,
        padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              backgroundImage: _getImageProvider(),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '姓名:' + global.user.nickName,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '手机号:' + global.user.phone,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '授信额度:' + widget.applyAmount + '元',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  buildItems(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(),
      ],
    );
  }

  Global global = Global();

  ImageProvider _getImageProvider() {
    if (global.user.avatarUrl == null || global.user.avatarUrl == '') {
      return AssetImage('assets/images/header.png');
    } else {
      return NetworkImage(global.user.avatarUrl);
    }
  }

}
