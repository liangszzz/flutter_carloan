import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/Global.dart';
import 'package:flutter_carloan/myBankCard/myBankCard.dart';

class MyBankCardPage extends StatefulWidget {
  // 其他页面传来的身份证号码
  final String idCard;

  const MyBankCardPage({Key key, this.idCard}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new MyBankCardPageState(idCard: idCard);
  }
}

class MyBankCardPageState extends State<MyBankCardPage> {
  MyBankCardPageState({
    this.idCard,
  });

  // 是否加载过数据
  bool _loaded = false;

  // 银行卡信息列表
  List<MyBankCard> _myBankCards = new List();

  // 字体
  static final String _arial = 'Arial';
  static final Color _blackColor = Color.fromRGBO(16, 16, 16, 1);
  static final Color _whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static final Color _blueColor = Color.fromRGBO(3, 169, 244, 1);
  static final Color _greyColor = Color.fromRGBO(234, 234, 234, 1);
  Global _global = new Global();
  static final String _requestPath = 'sign/queryBankCard/';

  // 身份证号码
  final String idCard;

  // 银行卡行的文本样式
  TextStyle _bankName = new TextStyle(
    color: _whiteColor,
    fontFamily: _arial,
    fontSize: 18,
  );

  // 签约时间的文本样式
  TextStyle _signDate = new TextStyle(
    color: _whiteColor,
    fontFamily: _arial,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    if (_loaded == false) {
      _getMyBankCards();
    }
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "我的银行卡",
          style: new TextStyle(
            fontFamily: _arial,
            fontSize: 16,
            color: _blackColor,
          ),
        ),
      ),
      body: _getMyBankCardsWidget(),
    );
  }

  Widget _getMyBankCardsWidget() {
    // body一样大，灰色背景
    return new Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      color: _greyColor,
      child: ListView.builder(
        itemBuilder: (context, i) {
          if (i < _myBankCards.length) {
            // 蓝色背景Container
            return new Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Material(
                borderRadius: BorderRadius.circular(15),
                color: _blueColor,
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _getBankNameRow(i),
                      _getSignDateRow(i),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  /// 银行卡名行
  Widget _getBankNameRow(index) {
    String bankNameAndNo;
    String bankName = _myBankCards[index].bankName;
    String cardNo = _myBankCards[index].cardNo;
    if (bankName.isNotEmpty && cardNo.isNotEmpty) {
      bankNameAndNo = bankName + "（尾号" + cardNo + "）";
    }
    return new Container(
      height: 60,
      alignment: Alignment.centerLeft,
      child: new Text(
        bankNameAndNo,
        style: _bankName,
      ),
    );
  }

  /// 签约日期行
  Widget _getSignDateRow(index) {
    return new Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 10,
      ),
      height: 30,
      child: new Text(
        "签约日期：" + _myBankCards[index].signDate,
        style: _signDate,
      ),
    );
  }

  /// 获取银行卡数据
  void _getMyBankCards() async {
    if(widget.idCard == '' || widget.idCard == null){
      return;
    }
    try {
      Map responseData = await _global.post(_requestPath + idCard);
      List data = responseData['data'];
      for (int i = 0; i < data.length; i++) {
        MyBankCard card = new MyBankCard();
        card.idCard = data[i]['idcard'];
        card.bankName = data[i]['bank_name'];
        card.signDate = data[i]['create_time'];
        card.cardNo = data[i]['bankcard'];
        _myBankCards.add(card);
      }
      setState(() {
        _loaded = true;
      });
    } catch (e) {
      print(e);
    }
  }
}
