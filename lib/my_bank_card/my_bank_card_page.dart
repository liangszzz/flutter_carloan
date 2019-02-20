import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_carloan/my_bank_card/my_bank_card.dart';

class MyBankCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyBankCardPageState();
  }
}

class MyBankCardPageState extends State<MyBankCardPage> {
  bool _loaded = false;
  List<MyBankCard> _myBankCards = new List();

  @override
  Widget build(BuildContext context) {
    if (_loaded == false) {
      _loaded = true;
      _getMyBankCards();
    }
    return new Container(
      padding: EdgeInsets.only(top: 20.0),
      decoration: new BoxDecoration(color: Colors.grey[200]),
      child: ListView.builder(itemBuilder: (context, i) {
        if (i < _myBankCards.length) {
          return new Container(
              height: 100.0,
              padding: EdgeInsets.only(
                  right: 10.0, left: 10.0, top: 5.0, bottom: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue[400],
                child: Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15.0, left: 10.0),
                        child: new Text(
                          _myBankCards[i].bankName + "（尾号" + _myBankCards[i].cardNo + "）",
                          style: new TextStyle(
                              fontSize: 22.0, color: Colors.white),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10.0, left: 10.0),
                          child: new Text(
                            "签约日期：" + _myBankCards[i].signDate,
                            style: new TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ));
        }
      }),
    );
  }

  void _getMyBankCards() async {
    try {
      Dio dio = new Dio();
      String path = "http://192.168.1.3:8081/sign/queryBankCard/";
      String idCard = "411502199112119312";
      Response response = await dio.post(path + idCard);
      List data = response.data['data'];
      setState(() {
        for (int i = 0; i < data.length; i++) {
          MyBankCard card = new MyBankCard();
          card.idCard = data[i]['idcard'];
          card.bankName = data[i]['bank_name'];
          card.signDate = data[i]['create_time'];
          card.cardNo = data[i]['bankcard'];
          _myBankCards.add(card);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
