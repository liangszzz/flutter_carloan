import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';

class MeHeader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHeaderPage();
  }
}

class MyHeaderPage extends State<MeHeader> {
  var applyAmount = "0.0";
  var isReload = false;

  @override
  Widget build(BuildContext context) {
    if (!isReload) {
      _getRecentRecord();
      isReload = true;
    }

    return GestureDetector(
      child: Container(
        color: Colors.blueAccent,
        padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(global.user.avatarUrl),
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
                    '授信额度:' + applyAmount.toString() + '元',
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

  _getRecentRecord() async {
    if(global.user.idCard == null || global.user.idCard == ''){
      return;
    }
    var response = await global.post("user/getRecentOrder/"+ global.user.idCard);
    DataResponse d = DataResponse.fromJson(response);
    setState(() {
      if (d.success()) {
        Map<String, Object> map = d.entity as Map;
        applyAmount = map['apply_amount'];
      }
    });
  }
}
