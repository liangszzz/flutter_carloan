import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/order/order.dart';
import 'package:flutter_carloan/repayment/repayment_page.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderPageState();
  }
}

class OrderPageState extends State<OrderPage> {
  static final String _arial = 'Arial';
  static final Color _blackColor = Color.fromRGBO(16, 16, 16, 1);
  static final Color _blueColor = Color.fromRGBO(3, 169, 244, 1);
  static final Color _greyColor = Color.fromRGBO(242, 242, 242, 1);
  static final Color _deepGreyColor = Color.fromRGBO(170, 170, 170, 1);
  static final Color _whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static final Color _readColor = Color.fromRGBO(229, 28, 35, 1);

  Color _recent = _blackColor;
  Color _all = _deepGreyColor;

  final Global _global = new Global();
  static final String requestPath = 'user/orders';
  double remainingPrincipalTotal = 0;
  List<Order> orders = new List();

  // 展示最近订单（true：最近订单，false：所有订单）
  bool recentOrder = true;
  bool hasLoaded = false;

  void _changeTitleColor() {
    Color temp = _recent;
    _recent = _all;
    _all = temp;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!hasLoaded) {
      _getUserOrders();
    }

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "车贷平台",
          style: new TextStyle(
            fontFamily: _arial,
            fontSize: 16,
            color: _blackColor,
          ),
        ),
      ),
//      body: new Container(
//        color: _greyColor,
//        child: _getMainList(),
//      ),
    body: new RefreshIndicator(
      displacement: 40,
      onRefresh: _pullDownToFlush,
      child: new Container(
        color: _greyColor,
        child: _getMainList(),
      ),
    ),
    );
  }

  Widget _getMainList() {
    List<Order> showOrders = new List();
    if (recentOrder) {
      // 返回最近订单组件
      if (orders.length > 0) {
        showOrders.add(orders[0]);
      }
    } else {
      // 返回全部订单组件
      showOrders = orders;
    }

    return ListView.builder(
      itemBuilder: (context, i) {
        // 顶部借款信息
        if (i == 0) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            padding: EdgeInsets.only(top: 22, bottom: 14),
            child: _getApplyRow(),
            decoration: BoxDecoration(
              color: _whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          );
        }
        // 近期订单/全部订单菜单
        if (i == 1) {
          return Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            color: _whiteColor,
            margin: EdgeInsets.only(bottom: 2),
            child: _getTitleRow(),
          );
        }
        // 订单信息
        if (i < showOrders.length + 2) {
          return Container(
            color: _whiteColor,
            padding: EdgeInsets.only(left: 16, right: 13, top: 16, bottom: 7),
            margin: EdgeInsets.only(bottom: 3),
            child: _getOrderList(i - 2),
          );
        }
      },
    );
  }

  Widget _getApplyRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "未还本金总额（元）",
          style: TextStyle(
            fontSize: 13,
            fontFamily: _arial,
            color: _blackColor,
          ),
        ),
        Text(
          remainingPrincipalTotal.toString(),
          style: TextStyle(
            fontSize: 28,
            color: _blackColor,
            fontFamily: _arial,
          ),
        ),
        Material(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: RaisedButton(
            color: _whiteColor,
            child: Text(
              "我要借款",
              style: TextStyle(
                color: _blueColor,
                fontSize: 14,
                fontFamily: _arial,
              ),
            ),
            onPressed: () {
              print("正在申请*********");
            },
          ),
        ),
      ],
    );
  }

  Widget _getTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // 灰色时点击生效
            if (_recent == _deepGreyColor) {
              recentOrder = true;
              _changeTitleColor();
            }
          },
          child: Container(
            child: Text(
              "近期订单",
              style: TextStyle(
                fontSize: 14,
                color: _recent,
                fontFamily: _arial,
              ),
            ),
          ),
        ),
        Container(
          color: _greyColor,
          width: 1.0,
          height: 30.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: GestureDetector(
            onTap: () {
              if (_all == _deepGreyColor) {
                recentOrder = false;
                _changeTitleColor();
              }
            },
            child: Container(
              child: Text(
                "全部订单",
                style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 14,
                  color: _all,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getOrderList(int index) {
    return GestureDetector(
      onTap: _tapOrder,
      child: Column(
        children: <Widget>[
          _getRepayDateRow(index),
          _getApplyAmountRow(index),
          _getBankCardInfoRow(index),
        ],
      ),
    );
  }

  Widget _getRepayDateRow(int index) {
    String msg = '';
    Order order = orders[index];
    int status = order.orderStatus;
    if (status == 64) {
      if (order.latestRepayDate != null) {
        msg = order.latestRepayDate + '应还金额';
      }
    }
    return Container(
      color: _whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Expanded(
              child: Text(
                '1月1日应还金额',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Arial',
                  color: _blackColor,
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              "还剩0天还款",
              style: TextStyle(
                  color: _readColor, fontSize: 14, fontFamily: _arial),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getApplyAmountRow(int index) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      color: _whiteColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "100000(元)",
              style: TextStyle(
                fontSize: 20,
                fontFamily: _arial,
                color: _blackColor,
              ),
            ),
          ),
          Image.asset(
            "img/right.png",
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget _getBankCardInfoRow(int index) {
    return Container(
      color: _whiteColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "还款日当天从中国银行（尾号8888）自动扣款",
              style: TextStyle(
                color: _deepGreyColor,
                fontSize: 13,
                fontFamily: _arial,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getFootNavigator() {

  }

  /// 调整到订单详情界面
  void _tapOrder() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RepaymentPage()));
  }

  /// 获取订单列表信息
  void _getUserOrders() async {
    Map requestData = {'idcard': '140301199211123815'};
    Map responseData = await _global.postFormData(requestPath, requestData);
    Map data = responseData['entity'];
    if (data != null) {
      remainingPrincipalTotal = data['remainingPrincipalTotal'];
      List orderList = data['orders'];
      List date = new List();
      for (int i = 0; i < orderList.length; i++) {
        Order order = new Order();
        order.bizOrderNo = orderList[i]['bizOrderNo'];
        order.latestRepayDate = orderList[i]['latestRepayDate'];
        order.latestRepayDays = orderList[i]['latestRepayDays'];
        order.latestShouldRepayAmount = orderList[i]['latestShouldRepayAmount'];
        order.loanAmount = orderList[i]['loanAmount'];
        order.bankName = orderList[i]['bankName'];
        order.bankNoTail = orderList[i]['bankNoTail'];
        order.orderStatus = int.parse(orderList[i]['orderStatus']);
        date = orderList[i]['loadDate'];
        if (date != null) {
          order.loanDate = date[1].toString() + '月' + date[2].toString() + '日';
        }
        if (orderList[i]['wxAppConfirm'] == 1) {
          order.hasConfirm = true;
        } else {
          order.hasConfirm = false;
        }
        orders.add(order);
      }
    }

    print('*********************');
    print('remaining amount:' + remainingPrincipalTotal.toString());
    for (int i = 0; i < orders.length; i++) {
      print('bizOrderNo:' + orders[i].bizOrderNo);
      print('apply amount:' + orders[i].loanAmount.toString());
      print('order status:' + orders[i].orderStatus.toString());
      print('has confirmed:' + orders[i].hasConfirm.toString());
    }
    print('*********************');
    setState(() {
      hasLoaded = true;
    });
  }

  /// 下拉刷新方法
  Future _pullDownToFlush() async {
    setState(() {
      hasLoaded = false;
    });
  }


}
