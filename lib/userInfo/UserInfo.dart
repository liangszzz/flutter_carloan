import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/RadioBox.dart';
import 'package:flutter_carloan/userInfo/UserInfoCell.dart';

///在keyName后面添加了空格来对齐value
class UserInfo extends StatelessWidget {
  Widget buildCells(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UserInfoCell(
            keyName: '真实姓名  ',
            valueName: '张三',
            imgSrc: 'img/blank_right.png',
            onPressed: () {},
          ),
          UserInfoCell(
            keyName: '身份证      ',
            valueName: '45465456456456',
            imgSrc: 'img/blank_right.png',
            onPressed: () {},
          ),

          UserInfoCell(
            keyName: '身份类型  ',
            valueName: '在职',
            imgSrc: 'img/arrow_right.png',
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                return new RadioBox(RadioType:'123');
              }));
            },
          ),




        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('个人资料'), elevation: 0.5),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10),
              buildCells(context),
            ],
          ),
        ),
    );
  }
}
