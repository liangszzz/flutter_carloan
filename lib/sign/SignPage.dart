import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/agreement/AgreementPageInfo.dart';
import 'package:flutter_carloan/app/CodeButton.dart';
import 'package:flutter_carloan/app/CommonButton.dart';
import 'package:flutter_carloan/app/DialogUtils.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/repayment/repaymentPage.dart';
import 'package:flutter_carloan/sign/UserSign.dart';

///签约代扣
class SignPage extends StatelessWidget {
  final String bizOrderNo;

  ///1 表示正式表 2 表示微信表
  final int channelType;

  const SignPage(
      {Key key, @required this.bizOrderNo, @required this.channelType})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _SignPageStateful(
        bizOrderNo: bizOrderNo,
        channelType: channelType,
      );
}

class _SignPageStateful extends StatefulWidget {
  final String bizOrderNo;

  final int channelType;

  const _SignPageStateful(
      {Key key, @required this.bizOrderNo, @required this.channelType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignPageState();
}

class _SignPageState extends State<_SignPageStateful> {
  Global global = new Global();

  bool signed = false;
  UserSign userSign;

  ///当前选择的银行
  var currentSelectBankIndex = 0;

  var formKey = new GlobalKey<FormState>();
  var userName = new TextEditingController();
  var idCard = new TextEditingController();
  var bankCard = new TextEditingController();
  var phone = new TextEditingController();
  var code = new TextEditingController();
  var smsId;

  int second = 0;

  bool checkboxSelected = false;

  var agreementTitle = "自动还款协议";

  @override
  void initState() {
    checkSign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: _buildBody(),
      ));

  Widget _buildTitle() {
    const TextStyle textStyle = TextStyle(fontSize: 14);
    return Text("签约代扣", style: textStyle);
  }

  Widget _buildBody() {
    sleep(const Duration(milliseconds: 200));
    if (signed) {
      return _buildSigned();
    }
    return _buildNoSign();
  }

  ///已签约
  Widget _buildSigned() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Form(
        key: formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            _buildText(),
            SizedBox(
              height: 10,
            ),
            _buildUserName(),
            _buildIdCard(),
            _buildBankList(),
            _buildBankCard(),
            _buildPhone(),
            SizedBox(
              height: 20,
            ),
            _buildBottom(),
            _buildBtn(),
          ],
        ),
      ),
    );
  }

  ///未签约
  Widget _buildNoSign() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Form(
        key: formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            _buildText(),
            SizedBox(
              height: 10,
            ),
            _buildUserName(),
            _buildIdCard(),
            _buildBankList(),
            _buildBankCard(),
            _buildPhone(),
            _buildCode(),
            SizedBox(
              height: 20,
            ),
            _buildBottom(),
            _buildBtn(),
          ],
        ),
      ),
    );
  }

  void checkSign() async {
    var url =
        "sign/toCheckSign/${this.widget.bizOrderNo}/${this.widget.channelType}";
    var response = await global.post(url);
    DataResponse d = DataResponse.fromJson(response);
    if (d.success()) {
      ///已签约
      setState(() {
        signed = true;
        userSign = UserSign.fromJson(d.dataMap);
        currentSelectBankIndex = userSign.index;
      });
    } else {
      setState(() {
        signed = false;
        userSign = UserSign.fromJson(d.dataMap);
        currentSelectBankIndex = 0;
      });
    }
    userName.text = userSign.userName;
    idCard.text = userSign.idCard;
    bankCard.text = userSign.bankCard;
    phone.text = userSign.reservePhone;
  }

  @override
  void dispose() {
    super.dispose();
    userName.dispose();
    idCard.dispose();
    bankCard.dispose();
    phone.dispose();
  }

  Widget _buildText() {
    return Text(
      "添加您的银行卡用于还款",
      style: TextStyle(color: Colors.black87, fontSize: 13),
    );
  }

  var blank = Text("  ");

  ///持卡人
  Widget _buildUserName() {
    return TextFormField(
        controller: userName,
        keyboardType: TextInputType.text,
        maxLength: 20,
        decoration: InputDecoration(
          hintText: "请输入持卡人姓名",
          prefixText: "持卡人:",
          prefixStyle: TextStyle(color: Colors.black),
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ));
  }

  ///身份证号
  Widget _buildIdCard() {
    return TextFormField(
        controller: idCard,
        keyboardType: TextInputType.text,
        maxLength: 18,
        decoration: InputDecoration(
          hintText: "请输入持卡人身份证号",
          prefixText: "身份证号:",
          prefixStyle: TextStyle(color: Colors.black),
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ));
  }

  ///签约银行
  Widget _buildBankList() {
    var text = DropdownButtonFormField(
      items: _getBankList(),
      value: currentSelectBankIndex,
      decoration: InputDecoration(
        counterText: "选择",
        prefixText: "签约银行:",
        prefixStyle: TextStyle(color: Colors.black),
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      onChanged: (value) {
        setState(() {
          currentSelectBankIndex = value;
        });
      },
    );
    return text;
  }

  ///加载银行列表
  List<DropdownMenuItem> _getBankList() {
    List<DropdownMenuItem> list = new List();
    for (var i = 0; i < UserSign.bankList.length; i++) {
      var bankName = UserSign.bankList[i];
      list.add(DropdownMenuItem(
        child: Text("$bankName"),
        value: i,
      ));
    }
    return list;
  }

  ///加载银行卡号
  Widget _buildBankCard() {
    var text = TextFormField(
        controller: bankCard,
        keyboardType: TextInputType.number,
        maxLength: 19,
        decoration: InputDecoration(
          hintText: "请输入银行卡号",
          prefixText: "银行卡号:",
          prefixStyle: TextStyle(color: Colors.black),
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ));

    return text;
  }

  ///加载手机号
  Widget _buildPhone() {
    var text = TextFormField(
        controller: phone,
        keyboardType: TextInputType.number,
        maxLength: 11,
        decoration: InputDecoration(
          hintText: "请输入银行预留手机号",
          prefixText: "手机号:",
          prefixStyle: TextStyle(color: Colors.black),
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ));

    return text;
  }

  ///加载验证码
  Widget _buildCode() {
    var text = TextFormField(
      controller: code,
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration: InputDecoration(
          hintText: "请输入验证码",
          prefixText: "验证码:",
          prefixStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          suffix: CodeButton(
            callback: _getSmsCode,
//            second: second,
          )),
    );
    return text;
  }

  void _getSmsCode() async {
    //检查
    if (phone.text.length != 11) {
      DialogUtils.showAlertDialog(context, "提示", "请输入有效的手机号!", null,
          contentStyle: TextStyle(color: Colors.red));
      return;
    }
    var response = await global.postFormData("sign/signSms", {
      "payerName": userName.text,
      "payerCardNo": idCard.text,
      "payerBankCardNo": bankCard.text,
      "bankMobile": phone.text
    });
    var d = DataResponse.fromJson(response);
    if (d.success()) {
      smsId = d.msg;
    } else {
      DialogUtils.showAlertDialog(context, "提示", d.msg, null,
          contentStyle: TextStyle(color: Colors.red));
    }
  }

  ///创建协议页面
  Widget _buildBottom() {
    var checkBox = Checkbox(
        value: checkboxSelected,
        activeColor: Colors.blue,
        onChanged: (value) {
          setState(() {
            checkboxSelected = value;
          });
        });
    var text = Text(
      "我已阅读并理解",
      style: TextStyle(color: Colors.black87, fontSize: 13),
    );

    var agreement = Text(
      "《自动还款协议》",
      style: TextStyle(color: Colors.blue, fontSize: 13),
    );

    return Row(
      children: <Widget>[
        checkBox,
        text,
        new GestureDetector(
          child: agreement,
          onTap: _toAgreement,
        )
      ],
    );
  }

  ///创建按钮
  Widget _buildBtn() {
    return CommonButton(text: "下一步", onClick: _doSign);
  }

  ///签约
  void _doSign() async {
    if (signed) {
      Navigator.push(context, new MaterialPageRoute(builder: (context) {
        return RepaymentPage(
          bizOrderNo: widget.bizOrderNo,
          isConfirm: true,
          channelType: widget.channelType,
        );
      }));
      return;
    }
    if(!checkboxSelected){
      DialogUtils.showAlertDialog(context, "提示", "请先阅读同意自动还款协议!", null,
          contentStyle: TextStyle(color: Colors.red));
      return;
    }

    if(smsId==null){
      DialogUtils.showAlertDialog(context, "提示", "请先获取短信验证码!", null,
          contentStyle: TextStyle(color: Colors.red));
      return;
    }

    if(code.text==null){
      DialogUtils.showAlertDialog(context, "提示", "短信验证码为空!", null,
          contentStyle: TextStyle(color: Colors.red));
      return;
    }

    var response = await global.postFormData("sign/doSign", {
      "smsId": smsId,
      "smsCode": code.text,
      "payerName": userName.text,
      "payerCardNo": idCard.text,
      "payerBankCardNo": bankCard.text,
      "bankMobile": phone.text,
      "openId": global.token.token
    });
    var d = DataResponse.fromJson(response);
    if (d.success()) {
      ///签约成功
      DialogUtils.showAlertDialog(context, "提示", "签约成功!!", null);
      global.user.bankName = UserSign.bankList[currentSelectBankIndex];
      global.user.barkCard = bankCard.text.substring(bankCard.text.length - 4);

      ///跳转
      Navigator.push(context, new MaterialPageRoute(builder: (context) {
        return RepaymentPage(
          bizOrderNo: widget.bizOrderNo,
          isConfirm: true,
          channelType: widget.channelType,
        );
      }));
    } else {
      DialogUtils.showAlertDialog(context, "提示", d.msg, null,
          contentStyle: TextStyle(color: Colors.red));
    }
  }

  ///跳转自动还款协议页面
  void _toAgreement() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return AgreementInfoPage(
          title: agreementTitle,
          bizOrderNo: widget.bizOrderNo,
          channelType: widget.channelType);
    }));
  }
}
