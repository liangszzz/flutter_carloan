import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/CodeButton.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';

///登陆页面
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _LoginStateful();
}

class _LoginStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginStateful> {
  Global global = new Global();

  ///登陆方式 true 免密登陆,false 密码登陆
  bool _loginType = true;

  ///显示密码 true 不显示
  bool _showPwd = true;
  TextEditingController _phone = new TextEditingController();
  TextEditingController _codeOrPwd = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  int second = 0;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _loginType
              ? Text("免密码登陆", style: TextStyle(fontSize: 14))
              : Text("密码登陆", style: TextStyle(fontSize: 14)),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: _loginType ? _buildLoginBySms() : _buildLoginByPwd());
  }

  ///免密登陆
  Widget _buildLoginBySms() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            _buildPhone(),
            _buildSmsCode(),
            SizedBox(
              height: 20,
            ),
            _buildLogin(),
            SizedBox(
              height: 10,
            ),
            _buildBottomBySms()
          ],
        ),
      ),
    );
  }

  ///密码登陆
  Widget _buildLoginByPwd() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            _buildPhone(),
            _buildPwd(),
            SizedBox(
              height: 20,
            ),
            _buildLogin(),
            SizedBox(
              height: 10,
            ),
            _buildBottomByPwd()
          ],
        ),
      ),
    );
  }

  ///创建手机号
  Widget _buildPhone() {
    return TextFormField(
      controller: _phone,
      keyboardType: TextInputType.number,
      maxLength: 11,
      maxLengthEnforced: true,
      decoration: InputDecoration(
          hintText: "请输入手机号",
          icon: Icon(
            Icons.phone_iphone,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none)),
      validator: (v) {
        if (v.isEmpty) {
          return "请输入手机号";
        }
        if (v.length < 11) {
          return "请输入正确手机号";
        }
      },
    );
  }

  ///创建验证码
  Widget _buildSmsCode() {
    return Wrap(
      direction: Axis.horizontal,
      children: <Widget>[
        TextFormField(
          controller: _codeOrPwd,
          maxLength: 4,
          maxLengthEnforced: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "请输入验证码",
            icon: Icon(
              Icons.message,
              color: Colors.grey,
            ),
            suffix: CodeButton(
              onPress: _getSmsCode,
              second: second,
            ),
          ),
          validator: (v) {
            if (v.isEmpty) {
              return "请输入验证码";
            }
            if (v.length < 4) {
              return "请输入正确验证码";
            }
          },
        ),
      ],
    );
  }

  ///创建密码
  Widget _buildPwd() {
    return TextFormField(
      controller: _codeOrPwd,
      maxLength: 50,
      maxLengthEnforced: true,
      keyboardType: TextInputType.text,
      obscureText: _showPwd,
      decoration: InputDecoration(
          labelText: "密码",
          hintText: "请输入密码",
          icon: Icon(Icons.lock),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _showPwd = !_showPwd;
                });
              })),
      validator: (v) {
        if (v.isEmpty) {
          return "请输入密码";
        }
        if (v.length < 6) {
          return "密码必须大于6位";
        }
      },
    );
  }

  ///创建登陆按钮
  Widget _buildLogin() {
    var btn = FlatButton(
        onPressed: _login,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: Colors.green,
        child: Text(
          "登陆",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ));
    return Row(
      children: <Widget>[Expanded(child: btn)],
    );
  }

  ///创建免密登陆底部
  Widget _buildBottomBySms() {
    var text = Text("未注册手机验证后自动登陆",
        style: TextStyle(fontSize: 12, color: Colors.grey));

    var btn = FlatButton(
      child: Text("密码登陆", style: TextStyle(color: Colors.blue, fontSize: 14)),
      onPressed: _setLoginType,
    );

    return Row(
      children: <Widget>[
        text,
        Expanded(
          child: Container(),
        ),
        btn
      ],
    );
  }

  ///创建密登陆底部
  Widget _buildBottomByPwd() {
    var forgetBtn = FlatButton(
      child: Text("忘记密码?", style: TextStyle(color: Colors.blue, fontSize: 14)),
    );
    var btn = FlatButton(
      child: Text("免密登陆", style: TextStyle(color: Colors.blue, fontSize: 14)),
      onPressed: _setLoginType,
    );
    return Row(
      children: <Widget>[
        forgetBtn,
        Expanded(
          child: Container(),
        ),
        btn
      ],
    );
  }

  void _getSmsCode() async {
    if (_phone.text.length != 11) {
      return;
    }
    var response = await global.post("login/wxSendSms/" + _phone.text);

    DataResponse d = DataResponse.fromJson(json.decode(response));

    if (d.success()) {
      setState(() {
        second = 10;
      });
      _secondUpdate();
    }
  }

  void _secondUpdate() {
    timer = Timer(Duration(seconds: 1), () {
      setState(() {
        --second;
      });
      _secondUpdate();
    });
  }

  void _setLoginType() {
    setState(() {
      _loginType = !_loginType;
    });
  }

  void _login() {}

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
