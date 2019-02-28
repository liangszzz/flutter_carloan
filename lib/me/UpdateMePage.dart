
import 'package:flutter/material.dart';
import 'package:flutter_carloan/me/MeCell.dart';
import 'package:flutter_carloan/me/UpdatePwdPage.dart';
import 'package:flutter_carloan/me/UpdateUserInfoPage.dart';

///更新个人信息
class UpdateMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _UpdateMeStateful();
}

class _UpdateMeStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpdateMeState();
}

class _UpdateMeState extends State<_UpdateMeStateful> {

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: _buildUpdateMe(),
      ));

  ///创建标题
  Widget _buildTitle() {
    const TextStyle textStyle = TextStyle(fontSize: 16);
    return Text("修改信息", style: textStyle);
  }

  Widget _buildUpdateMe() {
    return Container(
      child: Column(
        children: <Widget>[
          MeCell(
            title: '更新个人信息',
            iconName: 'assets/images/person.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdateUserInfoPage();
              }));
            },
          ),
          MeCell(
            title: '修改密码',
            iconName: 'assets/images/password.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdatePwdPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
