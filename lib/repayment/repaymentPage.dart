import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carloan/agreement/AgreementPageInfo.dart';
import 'package:flutter_carloan/auditLenders/AuditLendersPage.dart';
import 'package:flutter_carloan/app/Global.dart';
import 'package:flutter_carloan/repayment/bill.dart';

class RepaymentPage extends StatefulWidget {
  RepaymentPage({
    @required this.bizOrderNo,
    @required this.isConfirm,
    @required this.channelType,
  });

  final String bizOrderNo;
  final bool isConfirm;
  final num channelType;

  @override
  State<StatefulWidget> createState() {
    return RepaymentPageState(
      bizOrderNo: bizOrderNo,
      isConfirmPage: isConfirm,
      channelType: channelType,
    );
  }
}

class RepaymentPageState extends State<RepaymentPage> {
  RepaymentPageState({
    @required this.bizOrderNo,
    @required this.isConfirmPage,
    @required this.channelType,
  });

  Global global = new Global();

  // 外单号
  final String bizOrderNo;

  // 是否是确认界面
  final bool isConfirmPage;

  // 订单渠道（1.新渠道、移动端，2.旧渠道）
  final num channelType;

  // 申请金额，如果是旧渠道则是显示transfer amount
  num applyAmount;

  // 利息利率
  double interestRate;

  // 总期数
  int terms;

  // 还款方式
  num method;

  // 申请信息是否改变（确认借款界面需要，用来判断是更新预览还是确认借款）
  bool _applyDataChanged = false;

  // 订单详情URL
  String _requestPath = 'bill/billDetailMobile';

  // 申请借款初始化账单
  String _initBillPath = 'bill/initBills';

  // 申请信息改变，更新并预计算
  String _updateAndComputingPath = 'bill/afterChangeInitBills';

  // 确认借款
  String _confirmPath = 'bill/confirmOrderMsg';

  // 最大申请金额
  int _maxApplyAmount = 100000;

  // 是否已经初始化
  bool _hasInit = false;

  // 是否已经接受产品说明和合同
  bool _accept = false;

  // 显示用的账单列表
  List<Bill> _bills = new List();

  // 字体、颜色
  static String _arial = 'Arial';
  static Color _lightGreyColor = Color.fromRGBO(234, 234, 234, 1);
  static Color _greyColor = Color.fromRGBO(136, 136, 136, 1);
  static Color _blackColor = Color.fromRGBO(16, 16, 16, 1);
  static Color _blueColor = Color.fromRGBO(3, 169, 244, 1);
  static Color _redColor = Color.fromRGBO(229, 28, 35, 1);
  static Color _whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static Color _greenColor = Color.fromRGBO(70, 142, 82, 1);

  // 常用文本格式
  TextStyle _blue18 = TextStyle(
    color: _blueColor,
    fontFamily: _arial,
    fontSize: 18,
  );
  TextStyle _black14 = TextStyle(
    color: _blackColor,
    fontFamily: _arial,
    fontSize: 14,
  );
  TextStyle _black16 = TextStyle(
    color: _blackColor,
    fontFamily: _arial,
    fontSize: 16,
  );
  TextStyle _grey14 = TextStyle(
    color: _greyColor,
    fontFamily: _arial,
    fontSize: 14,
  );

  static final FocusNode _amountFocusNode = new FocusNode();


  TextEditingController _controller = TextEditingController();

  /// 金额输入框失去焦点事件
  void _bindTextFieldLostFocus() {
    _amountFocusNode.addListener(() {
      if(!_amountFocusNode.hasFocus) {
        if(_controller.text != '') {
          String text = _controller.text;
          double apply = double.parse(text);
          if (apply > _maxApplyAmount) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("抱歉，您申请的金额超过上限"),
                  );
                });
            _controller.text = applyAmount.toString();
          } else {
            if (applyAmount != apply) {
              setState(() {
                _applyDataChanged = true;
                applyAmount = apply;
              });
            }
          }
        }
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    _bindTextFieldLostFocus();
    if (!_hasInit) {
      _getRepaymentMsg();
    }
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "订单详情",
          style: _black16,
        ),
      ),
      body: Container(
        color: _lightGreyColor,
        child: Column(
          children: <Widget>[
            buildRepaymentDetailListView(),
          ],
        ),
      ),
    );
  }

  /// 贷款服务提供方组件
  Widget _buildLoanEmployerWidget() {
    return Container(
      padding: EdgeInsets.only(top: 7, bottom: 7, left: 13),
      decoration: new BoxDecoration(
        color: _whiteColor,
      ),
      child: Row(
        children: <Widget>[
          Text(
            "由大兴安岭农商银行提供贷款服务",
            style: TextStyle(
              color: _greyColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  /// 订单基础信息行
  Widget buildLoanRowWidget() {
    String interestRateShowMsg = '';
    if (interestRate != null) {
      interestRateShowMsg = (interestRate * 100).toString() + '%';
    }
    return Container(
      color: _whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              child: Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "申请金额（元）",
                      style: TextStyle(
                        color: _blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    child: _getApplyAmountWidget(),
                  ),
                ],
              ),
            ),
          )),
          Container(
            color: Colors.grey,
            width: 1.0,
            height: 50.0,
          ),
          Container(
            child: Expanded(
              child: Column(
                children: <Widget>[
                  Text("利率"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "年化",
                          style: _grey14,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          interestRateShowMsg,
                          style: _blue18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey,
            width: 1.0,
            height: 50.0,
          ),
          Container(
            child: Expanded(
              child: _buildLoanRowWidgetColumn(),
            ),
          ),
        ],
      ),
    );
  }

  /// 订单信息行里的一列
  Widget _buildLoanRowWidgetColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "期数",
          style: _black14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getTermWidget(),
            Text(
              "期",
              style: _grey14,
            ),
          ],
        ),
      ],
    );
  }

  Widget _getTermWidget() {
    if (isConfirmPage) {
      List<DropdownMenuItem> termsList = new List();
      DropdownMenuItem item1 = new DropdownMenuItem(value: 1, child: Text("1"));
      DropdownMenuItem item2 = new DropdownMenuItem(value: 3, child: Text("3"));
      DropdownMenuItem item3 = new DropdownMenuItem(value: 6, child: Text("6"));
      DropdownMenuItem item4 = new DropdownMenuItem(value: 9, child: Text("9"));
      DropdownMenuItem item5 =
          new DropdownMenuItem(value: 12, child: Text("12"));
      termsList.add(item1);
      termsList.add(item2);
      termsList.add(item3);
      termsList.add(item4);
      termsList.add(item5);

      return DropdownButton(
          items: termsList,
          value: terms,
          style: _blue18,
          onChanged: (value) {
            if (terms != value) {
              setState(() {
                terms = value;
                _applyDataChanged = true;
              });
            }
          });
    } else {
      return Text(
        terms.toString(),
        style: _blue18,
      );
    }
  }

  /// 账单明细标题栏
  Widget _buildRepaymentDetailTitle() {
    return Container(
      color: _whiteColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "账单明细",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Text(
              "还款方式:",
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: _getRepaymentMethodWidget(),
          ),
        ],
      ),
    );
  }

  /// 构建账单列表（包含头部的基础信息）
  Widget buildRepaymentDetailListView() {
    return Container(
      child: Expanded(
        child: ListView.builder(
          itemCount: _bills.length + 2,
          itemBuilder: (context, i) {
            // 顶部基础信息
            if (i == 0) {
              return Column(
                children: <Widget>[
                  _buildLoanEmployerWidget(),
                  buildLoanRowWidget(),
                  _buildRepaymentDetailTitle(),
                ],
              );
            }

            // 具体的账单列表
            if (i <= _bills.length) {
              return Container(
                margin: EdgeInsets.only(bottom: 6),
                padding:
                    EdgeInsets.only(left: 13, right: 16, top: 10, bottom: 16),
                decoration: BoxDecoration(
                  color: _whiteColor,
                ),
                child: Column(
                  children: <Widget>[
                    _buildRepaymentTermDateRow(i - 1),
                    _buildRepaymentTermDividerRow(),
                    _buildRepaymentTermAmountRow(i - 1),
                  ],
                ),
              );
            }

            return _getExplainAndConfirmButton();
          },
        ),
      ),
    );
  }

  /// 某一期view组件里的第一行（日期）
  Widget _buildRepaymentTermDateRow(int index) {
    int year = _bills[index].shouldPayDate[0];
    int month = _bills[index].shouldPayDate[1];
    int day = _bills[index].shouldPayDate[2];
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Text(
                  "第",
                  style: _black14,
                ),
                Text(
                  _bills[index].currentTerm.toString(),
                  style: _blue18,
                ),
                Text(
                  "期还款日",
                  style: _black14,
                ),
              ],
            ),
          ),
          Text(
            year.toString() + '-' + month.toString() + '-' + day.toString(),
            style: TextStyle(
              fontFamily: _arial,
              fontSize: 12,
              color: _greyColor,
            ),
          ),
        ],
      ),
    );
  }

  /// 分割线行
  Widget _buildRepaymentTermDividerRow() {
    return Container(
      color: Color.fromRGBO(234, 234, 234, 1),
      height: 2,
    );
  }

  /// 金额行
  Widget _buildRepaymentTermAmountRow(int index) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Container(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "还款金额",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: _arial,
                      color: _greyColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      _bills[index].amount.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: _arial,
                        color: _blueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: _getRepayButton(index),
          ),
        ],
      ),
    );
  }

  /// 每期账单后面的还款按钮
  Widget _getRepayButton(int index) {
    if (isConfirmPage) {
      // 确认界面不需要还款按钮
      return null;
    } else {
      // 已还清的返回组件
      if (_bills[index].status == 3) {
        return Text(
          "已还清",
          style: TextStyle(
            fontFamily: _arial,
            fontSize: 12,
            color: _blueColor,
          ),
        );
      }

      DateTime current = DateTime.now();
      DateTime today = DateTime(current.year, current.month, current.day);

      int year = _bills[index].shouldPayDate[0];
      int month = _bills[index].shouldPayDate[1];
      int day = _bills[index].shouldPayDate[2];

      DateTime shouldPayDate = DateTime(year, month, day);
      String btnString = '还款';
      // 当前期数还款按钮的颜色，如果是逾期还款为红色，正常还款为蓝色
      Color currentTermRepayButtonColor = _blueColor;

      // 没到还款日
      if (today.isBefore(shouldPayDate)) {
        return null;
      }

      if (today.isAfter(shouldPayDate)) {
        btnString = '逾期还款';
        currentTermRepayButtonColor = _redColor;
      }

      return RaisedButton(
        child: Text(
          btnString,
          style: TextStyle(
            fontFamily: _arial,
            fontSize: 14,
            color: _whiteColor,
          ),
        ),
        color: currentTermRepayButtonColor,
        onPressed: () {
          print("还款按钮被点击了......");
        },
      );
    }
  }

  /// 合同、产品说明和确认按钮
  Widget _getExplainAndConfirmButton() {
    if (isConfirmPage) {
      return Column(
        children: <Widget>[
          _getExplain(),
          _buildRepaymentConfirmButton(),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          _buildRepaymentConfirmButton(),
        ],
      );
    }
  }

  /// 合同与说明书行
  Widget _getExplain() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _accept,
          onChanged: (value) {
            setState(() {
              _accept = !_accept;
            });
          },
        ),
        GestureDetector(
          child: Text(
            '我已阅读和理解',
            style: TextStyle(
              fontFamily: _arial,
              fontSize: 12,
              color: _greyColor,
            ),
          ),
          onTap: () {
            setState(() {
              _accept = !_accept;
            });
          },
        ),
        GestureDetector(
          child: Text(
            '《借款合同》',
            style: TextStyle(
              fontFamily: _arial,
              fontSize: 12,
              color: _blueColor,
            ),
          ),
          onTap: () {
            print('点击了借款合同');
          },
        ),
        Text(
          '、',
          style: TextStyle(
            fontFamily: _arial,
            fontSize: 12,
            color: _greyColor,
          ),
        ),
        GestureDetector(
          child: Text(
            '《产品说明书》',
            style: TextStyle(
              fontFamily: _arial,
              fontSize: 12,
              color: _blueColor,
            ),
          ),
          onTap: () {
            _toAgreement();
          },
        ),
      ],
    );
  }

  /// 底部确认按钮
  Widget _buildRepaymentConfirmButton() {
    // 是否是确认界面
    if (isConfirmPage) {
      // 确认界面申请数据是否改变
      if (_applyDataChanged) {
        return Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Text(
                    "更新并预览",
                    style: TextStyle(
                      fontFamily: _arial,
                      fontSize: 14,
                      color: _whiteColor,
                    ),
                  ),
                  color: _greenColor,
                  onPressed: () {
                    _getUpdateRepaymentMsg();
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Text(
                    "确认借款",
                    style: TextStyle(
                      fontFamily: _arial,
                      fontSize: 14,
                      color: _whiteColor,
                    ),
                  ),
                  color: _blueColor,
                  onPressed: () {
                    if (!_accept) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('请先阅读《借款合同》和《产品说明》'),
                          );
                        },
                      );
                      return null;
                    }
                    _confirmLoan();
                  },
                ),
              ),
            ],
          ),
        );
      }
    } else {
      // 订单详情界面
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text(
                  "确认",
                  style: TextStyle(
                    fontFamily: _arial,
                    fontSize: 14,
                    color: _whiteColor,
                  ),
                ),
                color: _blueColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _getRepaymentMethodWidget() {
    if (isConfirmPage) {
      List<DropdownMenuItem> terms = new List();

      DropdownMenuItem item1 =
          new DropdownMenuItem(value: 1, child: Text("等额本息"));
      DropdownMenuItem item2 =
          new DropdownMenuItem(value: 4, child: Text("先息后本"));
      terms.add(item1);
      terms.add(item2);

      return DropdownButton(
        items: terms,
        value: method,
        style: TextStyle(
          fontFamily: _arial,
          fontSize: 14,
          color: _greyColor,
        ),
        onChanged: (value) {
          if (method != value) {
            setState(() {
              method = value;
              _applyDataChanged = true;
            });
          }
        },
      );
    } else {
      String s;
      if (method == 1) {
        s = '等额本息';
      } else {
        s = '先息后本';
      }
      return Text(
        s,
        style: TextStyle(
          fontFamily: _arial,
          fontSize: 14,
          color: _blueColor,
        ),
      );
    }
  }

  /// 获取申请金额组件，有两种返回情况（1.确认借款时返回输入框 2.查看账单时返回文本）
  Widget _getApplyAmountWidget() {

    if (isConfirmPage) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                style: _blue18,
                controller: _controller,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: applyAmount.toString(),
                  hintStyle: _blue18,
                  suffixStyle: TextStyle(
                    color: _blackColor,
                  ),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                maxLines: 1,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6)
                ],
                focusNode: _amountFocusNode,
//                onSubmitted: (text) {
//                  if (text.isEmpty) {
//                    return;
//                  }
//                  double apply = double.parse(text);
//                  if (apply > _maxApplyAmount) {
//                    showDialog(
//                        context: context,
//                        builder: (context) {
//                          return AlertDialog(
//                            content: Text("抱歉，您申请的金额超过上限"),
//                          );
//                        });
//                  } else {
//                    if (applyAmount != apply) {
//                      setState(() {
//                        _applyDataChanged = true;
//                        applyAmount = apply;
//                      });
//                    }
//                  }
//                },
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            applyAmount.toString(),
            style: _blue18,
          ),
        ],
      );
    }
  }



  /// 从后台获取订单详细信息
  void _getRepaymentMsg() async {
    List data = new List();
    _bills = new List();

    if (isConfirmPage) {
      Map requestData = {
        'bizOrderNo': bizOrderNo,
        'channelType': 1,
      };

      Map response = await global.postFormData(_initBillPath, requestData);
      data = response['entity']['bills'];
      applyAmount = response['entity']['applyAmount'];
      interestRate = response['entity']['rate'];
      terms = response['entity']['terms'];
      method = num.parse(response['entity']['method']);
      for (int i = 0; i < data.length; i++) {
        Bill bill = new Bill();
        bill.currentTerm = data[i]['currentTerm'];
        bill.shouldPayDate = data[i]['shouldPayDate'];
        bill.amount = data[i]['amount'];
        _bills.add(bill);
      }
    } else {
      Map requestData = {
        "bizOrderNo": bizOrderNo,
      };

      Map response = await global.postFormData(_requestPath, requestData);
      data = response['entity']['bills'];
      applyAmount = response['entity']['transferAmount'];
      interestRate = response['entity']['interestRate'];
      terms = int.parse(response['entity']['terms']);
      method = int.parse(response['entity']['method']);
      for (int i = 0; i < data.length; i++) {
        Bill bill = new Bill();
        bill.currentTerm = data[i]['currentRepaymentTerm'];
        bill.shouldPayDate = data[i]['shouldPayDate'];
        bill.amount = data[i]['shouldPayTotal'];
        bill.status = data[i]['billStatus'];
        _bills.add(bill);
      }
    }

    setState(() {
      _hasInit = true;
    });
  }

  /// 更新并重新计算账单（预计算，还没有保存）
  void _getUpdateRepaymentMsg() async {
    List data = new List();
    Map request = {
      'bizOrderNo': bizOrderNo,
      'applyAmount': applyAmount,
      'terms': terms,
      'method': method,
      'channelType': 1,
    };

    Map response = await global.postFormData(_updateAndComputingPath, request);
    data = response['entity']['bills'];

    _bills = new List();
    for (int i = 0; i < data.length; i++) {
      Bill bill = new Bill();
      bill.currentTerm = data[i]['currentTerm'];
      bill.shouldPayDate = data[i]['shouldPayDate'];
      bill.amount = data[i]['amount'];
      _bills.add(bill);
    }
    setState(() {
      _applyDataChanged = false;
    });
  }

  /// 确认借款方法
  void _confirmLoan() async {
    Map request = {
      'bizOrderNo': bizOrderNo,
      'applyAmount': applyAmount,
      'terms': terms,
      'method': method,
      'channelType': channelType,
    };
    try {
      Map response = await global.postFormData(_confirmPath, request);
      if (response['code'] == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuditLendersPage(
                 bizOrderNo: widget.bizOrderNo, channelType: 2,
                ),
          ),
        );
      } else {
        _showSaveFailDialog();
      }
    } catch (e) {
      _showSaveFailDialog();
    }
  }

  /// 保存失败弹框
  void _showSaveFailDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('保存失败，服务器内部异常'),
        );
      },
    );
  }

  ///跳转协议页面
  void _toAgreement() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return AgreementInfoPage(
        title: "借款合同",
        bizOrderNo: widget.bizOrderNo,
        channelType: widget.channelType,
        method: method.toString(),
        terms: terms.toString(),
        applyAmount: applyAmount.toString(),
      );
    }));
  }
}
