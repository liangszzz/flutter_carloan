import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/userInfo/CheckSexDialog.dart';
import 'package:flutter_carloan/userInfo/EditUserInfoPage.dart';
import 'package:flutter_carloan/userInfo/ShowPhoto.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _UserInfoPageState();
  }
}

class _UserInfoPageState extends State<UserInfoPage> {
  var userName = '张三';
  int groupValue = 1;
  var healLabel;
  var value;

  @override
  Widget build(BuildContext context) {

    List<DropdownMenuItem> getListData(String type){
      List<DropdownMenuItem> items=new List();
      DropdownMenuItem dropdownMenuItem3=new DropdownMenuItem(
        child:new Text('不知道'),
        value: '3',
      );
      items.add(dropdownMenuItem3);
      DropdownMenuItem dropdownMenuItem4=new DropdownMenuItem(
        child:new Text('放假了'),
        value: '4',
      );
      items.add(dropdownMenuItem4);
      return items;
    }

    switch (groupValue) {
      case 1:
        healLabel = '健康';
        break;
      case 2:
        healLabel = '良好';
        break;
      case 3:
        healLabel = '一般';
        break;
      case 4:
        healLabel = '较弱';
        break;
    }

    List<Widget> list = <Widget>[
      new Container(
        height: 24.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('      信息有误请及时联系客户经理修改',
                  style: TextStyle(
                      fontSize: 12.0, color: const Color(0xffAAAAAA))),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '真实姓名',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                '$userName',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
              ),
            ),
          ],
        ),
      ),
      new GestureDetector(
        onTap: _startEditUserInfoPage,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '身份证',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '445645478645645465',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '身份证地址',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                '江苏南京',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '现居地址',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                '$userName',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
              ),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '手机号码',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new Text(
                '18888888888',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
              ),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      new GestureDetector(
        onTap: _showCheckSexDiaolog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '健康状况',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$healLabel',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      new GestureDetector(
        onTap: _showPullDownSelect,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '身份类型',
                  style:
                  TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new DropdownButton(
                items: getListData('identity_type_flag'),
                value: value,//下拉菜单选择完之后显示给用户的值
                onChanged: (T){//下拉菜单item点击之后的回调
                  setState(() {
                    value=T;
                  });
                },
                elevation: 1,//设置阴影的高度
                style: new TextStyle(//设置文本框里面文字的样式
                  color: Colors.black, fontSize: 16.0,
                ),
                iconSize: 30.0,//设置三角标icon的大小
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      new GestureDetector(
        onTap: _showPullDownSelect,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '最高学历',
                  style:
                  TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new DropdownButton(
                items: getListData('degree_flag'),
                value: value,//下拉菜单选择完之后显示给用户的值
                onChanged: (T){//下拉菜单item点击之后的回调
                  setState(() {
                    value=T;
                  });
                },
                elevation: 1,//设置阴影的高度
                style: new TextStyle(//设置文本框里面文字的样式
                  color: Colors.black, fontSize: 16.0,
                ),
                iconSize: 30.0,//设置三角标icon的大小
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      new GestureDetector(
        onTap: _showPullDownSelect,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '客户职业信息',
                  style:
                  TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new DropdownButton(
                items: getListData('degree_flag'),
                value: value,//下拉菜单选择完之后显示给用户的值
                onChanged: (T){//下拉菜单item点击之后的回调
                  setState(() {
                    value=T;
                  });
                },
                elevation: 1,//设置阴影的高度
                style: new TextStyle(//设置文本框里面文字的样式
                  color: Colors.black, fontSize: 16.0,
                ),
                iconSize: 30.0,//设置三角标icon的大小
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      new GestureDetector(
        onTap: _showPullDownSelect,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '开户行',
                  style:
                  TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new DropdownButton(
                items: getListData('degree_flag'),
                value: value,//下拉菜单选择完之后显示给用户的值
                onChanged: (T){//下拉菜单item点击之后的回调
                  setState(() {
                    value=T;
                  });
                },
                elevation: 1,//设置阴影的高度
                style: new TextStyle(//设置文本框里面文字的样式
                  color: Colors.black, fontSize: 16.0,
                ),
                iconSize: 30.0,//设置三角标icon的大小
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      new GestureDetector(
        onTap: _showPullDownSelect,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '银行卡类型',
                  style:
                  TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new DropdownButton(
                items: getListData('degree_flag'),
                value: value,//下拉菜单选择完之后显示给用户的值
                onChanged: (T){//下拉菜单item点击之后的回调
                  setState(() {
                    value=T;
                  });
                },
                elevation: 1,//设置阴影的高度
                style: new TextStyle(//设置文本框里面文字的样式
                  color: Colors.black, fontSize: 16.0,
                ),
                iconSize: 30.0,//设置三角标icon的大小
              ),
            ],
          ),
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      new GestureDetector(
        onTap: _showPullDownSelect,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '婚姻状况',
                  style:
                  TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new DropdownButton(
                items: getListData('degree_flag'),
                value: value,//下拉菜单选择完之后显示给用户的值
                onChanged: (T){//下拉菜单item点击之后的回调
                  setState(() {
                    value=T;
                  });
                },
                elevation: 1,//设置阴影的高度
                style: new TextStyle(//设置文本框里面文字的样式
                  color: Colors.black, fontSize: 16.0,
                ),
                iconSize: 30.0,//设置三角标icon的大小
              ),
            ],
          ),
        ),
      ),



      ///分隔阴影
      new Container(
        height: 50.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('      联系人信息',
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Text(
              '联系人姓名',
              style: TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
            ),
            new Expanded(
              child: new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
                child: new Text(
                  '王二',
                  textAlign: TextAlign.right,
                  style:
                  TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ),
          ],
        ),
      ),

      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Text(
              '联系人电话',
              style: TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
            ),
            new Expanded(
              child: new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
                child: new Text(
                  '13888888888',
                  textAlign: TextAlign.right,
                  style:
                  TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ),
          ],
        ),
      ),

      new GestureDetector(
        onTap: _showPullDownSelect,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '联系人关系',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new DropdownButton(
                items: getListData('contact_relationship_flag'),
                value: value,//下拉菜单选择完之后显示给用户的值
                onChanged: (T){//下拉菜单item点击之后的回调
                  setState(() {
                    value=T;
                  });
                },
                elevation: 1,//设置阴影的高度
                style: new TextStyle(//设置文本框里面文字的样式
                    color: Colors.black, fontSize: 16.0,
                ),
                iconSize: 30.0,//设置三角标icon的大小
              ),
            ],
          ),
        ),
      ),

      ///
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///分隔阴影
      new Container(
        height: 50.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('      身份证正反面',
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
            ),
          ],
        ),
      ),

      new GestureDetector(
        onTap: _showPhotoPageState,
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  imageExpanded(url),
                  imageExpanded(url),
                ],
              ),
            ],
          ),
        ),

      ),

      ///分隔阴影
      new Container(
        height: 20.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('',
                  style: TextStyle(fontSize: 12.0, color: Colors.black)),
            ),
          ],
        ),
      ),

      new Padding(
        padding: new EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  print("点击按钮");
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                //通过控制 Text 的边距来控制控件的高度
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: new Text(
                    "修改",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    ];

    ///_getUserInfo();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            '个人信息',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: new Center(
          child: new ListView(children: list),
        ));
  }

  _startEditUserInfoPage() async {
    final result = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new EditUserInfoPage()),
    );
    setState(() {
      this.userName = result;
    });
  }


  _showPullDownSelect() async{
    print('123');
  }

  _showPhotoPageState() async {
    final result = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new ShowPhotoPage(url: url,)),
    );
    setState(() {
      this.userName = result;
    });
  }

  ///
  /// 展示选择性别的弹窗
  ///
  _showCheckSexDiaolog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new CheckSexDialog(
            groupValue: groupValue,
            onChanged: (int e) => updateGroupValue(e),
          );
        });
  }

  updateGroupValue(int e) {
    Navigator.pop(context);
    setState(() {
      this.groupValue = e;
    });
  }

  Global global = Global();
  _getUserInfo() async {
    var response = await global.post("user/getRecentOrder/320925199011273112");
    DataResponse d = DataResponse.fromJson(response);
    if (d.success()) {
      Map<String, Object> map = d.entity as Map;
    }
  }



  String url =
      "http://106.14.239.49/group1/M00/00/54/ag7vMVrxSQGARyXUABFLNLl3LrU142.jpg";

  Expanded imageExpanded(String url) {
    return new Expanded(
        child: new Container(
      decoration: new BoxDecoration(
          border: new Border.all(width: 1.0, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(6.0))),
      margin: const EdgeInsets.all(4.0),
      child: new Image(image: new NetworkImage(url), fit: BoxFit.scaleDown, width: 10.0, height: 100.0,),
    ));
  }
}
