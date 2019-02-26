import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/CodeButton.dart';
import 'package:flutter_carloan/app/CommonButton.dart';
import 'package:flutter_carloan/app/DialogUtils.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/me/MeScene.dart';

///更新密码
class UpdatePwdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _UpdatePwdStateful();
}

class _UpdatePwdStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpdateState();
}

class _UpdateState extends State<_UpdatePwdStateful> {
  Global global = new Global();
  TextEditingController newPwd = new TextEditingController();
  TextEditingController newPwdRepeat = new TextEditingController();
  TextEditingController smsCode = new TextEditingController();

  ///0 第一页 是新密码页  1 第二页是 接收验证码页
  int pageType = 0;

  bool showPwd = true;
  String btnText = "下一步";

  int second = 0;

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

  ///创建标题
  Widget _buildTitle() {
    const TextStyle textStyle = TextStyle(fontSize: 14);
    return Text("修改密码", style: textStyle);
  }

  ///创建页面
  Widget _buildBody() {
    if (pageType == 0) {
      return _buildNewPwd();
    } else if (pageType == 1) {
      return _buildSmsCode();
    }
    return null;
  }

  ///创建新密码
  Widget _buildNewPwd() {
    var pwd = TextFormField(
        controller: newPwd,
        maxLength: 50,
        maxLengthEnforced: true,
        keyboardType: TextInputType.text,
        obscureText: showPwd,
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
                    showPwd = !showPwd;
                  });
                })),
        validator: (v) {
          if (v.isEmpty) {
            return "请输入密码";
          }
          if (v.length < 6) {
            return "密码必须大于6位";
          }
        });

    var pwdRepeat = TextFormField(
      controller: newPwdRepeat,
      maxLength: 50,
      maxLengthEnforced: true,
      keyboardType: TextInputType.text,
      obscureText: showPwd,
      decoration: InputDecoration(
          labelText: "确认密码",
          hintText: "请再次输入密码",
          icon: Icon(Icons.lock),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  showPwd = !showPwd;
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        children: <Widget>[
          pwd,
          SizedBox(
            height: 20,
          ),
          pwdRepeat,
          SizedBox(
            height: 10,
          ),
          _buildBtn()
        ],
      ),
    );
  }

  ///创建验证码
  Widget _buildSmsCode() {
    var code = TextFormField(
        controller: smsCode,
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
            callback: _getSmsCode,
          ),
        ),
        validator: (v) {
          if (v.isEmpty) {
            return "请输入验证码";
          }
          if (v.length < 4) {
            return "请输入正确验证码";
          }
        });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
            child: Text("4位验证码已发送,请注意查收."),
          ),
          SizedBox(
            height: 20,
          ),
          code,
          SizedBox(
            height: 20,
          ),
          _buildBtn()
        ],
      ),
    );
  }

  ///创建按钮
  Widget _buildBtn() {
//    var btn = FlatButton(
//        onPressed: _btnClick,
//        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//        color: Colors.green,
//        child: Text(
//          btnText,
//          style: TextStyle(fontSize: 16, color: Colors.white),
//        ));
//    return Row(
//      children: <Widget>[Expanded(child: btn)],
//    );
    return CommonButton(text: btnText, onClick: _btnClick);
  }

  void _btnClick() async {
    if (pageType == 0) {
      //检查密码是否相等
      if (newPwd.text.length < 6 || newPwdRepeat.text.length < 6) {
        DialogUtils.showAlertDialog(context, "提示", "请填写大于6位的密码", null,
            contentStyle: TextStyle(color: Colors.red));
        return;
      }
      if (newPwd.text != newPwdRepeat.text) {
        DialogUtils.showAlertDialog(context, "提示", "两次密码不一致", null,
            contentStyle: TextStyle(color: Colors.red));
        return;
      }
      setState(() {
        pageType = 1;
        btnText = "修改";
      });
    } else if (pageType == 1) {
      //发送信息 修改密码
      if (smsCode.text.length != 4) {
        DialogUtils.showAlertDialog(context, "提示", "请输入4位验证码", null,
            contentStyle: TextStyle(color: Colors.red));
        return;
      }
      var url = "login/resetPwd";
      var data = {
        "phone": global.user.phone,
        "code": smsCode.text,
        "pwd": newPwd.text
      };
      var response = await global.post(url, data);
      DataResponse d = DataResponse.fromJson(response);
      if (d.success()) {
        DialogUtils.showAlertDialog(context, "提示", "修改密码成功", null);
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          return MeScene();
        }));
        return;
      }
    }
  }

  void _getSmsCode() async {
    var response = await global
        .post("login/sendAppSms/" + global.user.phone + "/updatePwd");
    DataResponse d = DataResponse.fromJson(response);
    if (d.success()) {
      print("#发送验证码成功!");
    }
  }
}
