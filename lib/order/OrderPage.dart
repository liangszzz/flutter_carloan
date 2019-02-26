import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/order/order.dart';
import 'package:flutter_carloan/repayment/repayment_page.dart';

class OrderPage extends StatefulWidget {
  OrderPage({
    this.idCard,
  });

  final String idCard;

  @override
  State<StatefulWidget> createState() {
    return OrderPageState(idCard: idCard);
  }
}

class OrderPageState extends State<OrderPage> {
  OrderPageState({
    this.idCard,
  });

  static final String _arial = 'Arial';
  static final Color _blackColor = Color.fromRGBO(16, 16, 16, 1);
  static final Color _blueColor = Color.fromRGBO(3, 169, 244, 1);
  static final Color _greyColor = Color.fromRGBO(242, 242, 242, 1);
  static final Color _deepGreyColor = Color.fromRGBO(170, 170, 170, 1);
  static final Color _whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static final Color _redColor = Color.fromRGBO(229, 28, 35, 1);

  Color _recent = _blackColor;
  Color _all = _deepGreyColor;

  final Global _global = new Global();
  static final String requestPath = 'user/orders';
  double remainingPrincipalTotal = 0;
  List<Order> orders = new List();

  // 展示最近订单（true：最近订单，false：所有订单）
  bool recentOrder = true;
  bool hasLoaded = false;
  final String idCard;

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

  /// 申请行
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

  /// 订单列表标题
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

  /// 订单列表
  Widget _getOrderList(int index) {
    Order order = orders[index];
    int status = order.orderStatus;

    String bizOrderNo = order.bizOrderNo;
    bool hasConfirmed = order.hasConfirm;
    double applyAmount = order.loanAmount;
//    int terms = order.term
    return GestureDetector(
      onTap: (){
        if(status == 64 || status == 68 || status == 72) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RepaymentPage(
                bizOrderNo: bizOrderNo,
                isConfirm: false,
              ),
            ),
          );
        }
        if(status == 19 && !hasConfirmed) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RepaymentPage(
                bizOrderNo: bizOrderNo,
                isConfirm: true,
              ),
            ),
          );
        }

      },
      child: Column(
        children: <Widget>[
          _getRepayDateRow(index),
          _getRemainingAmount(index),
          _getBankCardInfoRow(index),
        ],
      ),
    );
  }

  /// 还款日期、天数行
  Widget _getRepayDateRow(int index) {
    String msg = '';
    String showDate;
    Order order = orders[index];
    int status = order.orderStatus;
    Color showColor = _blueColor;
    if (status == 64) {
      showDate = order.latestRepayDate + '应还金额';
      msg = '还剩' + order.latestRepayDays.toString() + '天还款';
      showColor = _redColor;
    } else {
      showDate = order.loanDate + '申请借款';
    }
    if (status == 68 || status == 72) {
      msg = '已结清';
    }
    if (status == 19 && order.hasConfirm) {
      msg = '已确认';
    }
    if (status == 19 && !order.hasConfirm) {
      msg = '未确认';
    }
    if(status == 20) {
      msg = '审核中';
    }
    if(status == 21 || status == 22 || status == 61) {
      msg = '审核拒绝';
    }
    if(status == 62) {
      msg = '放款失败';
    }
//    switch(status) {
//      case 20:
//    }

    return Container(
      color: _whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Expanded(
              child: Text(
                showDate,
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
              msg,
              style: TextStyle(
                color: showColor,
                fontSize: 14,
                fontFamily: _arial,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 金额行
  Widget _getRemainingAmount(int index) {
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
            "assets/images/arrow_right.png",
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }

  /// 签约银行卡组件
  Widget _getBankCardInfoRow(int index) {
    return Container(
      color: _whiteColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '还款日当天从' +
                  orders[index].bankName +
                  '（尾号' +
                  orders[index].bankNoTail +
                  '）自动扣款',
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

  /// 获取订单列表信息
  void _getUserOrders() async {
    Map requestData = {'idcard': idCard};
    Map responseData = await _global.postFormData(requestPath, requestData);
    Map data = responseData['entity'];
    orders = new List();
    if (data != null) {
      remainingPrincipalTotal = data['remainingPrincipalTotal'];
      List orderList = data['orders'];
      List date = new List();
      for (int i = 0; i < orderList.length; i++) {
        Order order = new Order();
        order.bizOrderNo = orderList[i]['bizOrderNo'];
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
        date = orderList[i]['latestRepayDate'];
        if (date != null) {
          order.latestRepayDate = date[1].toString() + '月' + date[2].toString() + '日';
        }
        if (orderList[i]['wxAppConfirm'] == 1) {
          order.hasConfirm = true;
        } else {
          order.hasConfirm = false;
        }
        orders.add(order);
      }
    }

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
