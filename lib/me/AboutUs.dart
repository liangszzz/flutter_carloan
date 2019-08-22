import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/DataResponse.dart';
import 'package:flutter_carloan/app/Global.dart';

///关于我们信息
class AboutUsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool isReload = false;
  String company_name = "";
  String company_tel = "";

  @override
  Widget build(BuildContext context) {
    _getInfo();
    return Scaffold(
        appBar: AppBar(
          title: _buildTitle(),
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: _buildBody(),
          padding: new EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 30.0),
        ));
  }

  ///创建标题
  Widget _buildTitle() {
    const TextStyle textStyle = TextStyle(fontSize: 16);
    return Text("关于我们", style: textStyle);
  }

  Widget _buildBody() {
    return Container(
        alignment: Alignment.center,
        height: 180.0,
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            new Text(
              "$company_name",
              style: new TextStyle(fontSize: 20.0),
            ),
            new SizedBox(
              height: 30.0,
            ),
            new Text(
              "$company_tel",
              style: new TextStyle(fontSize: 16.0),
            )
          ],
        ));
  }

  Global global = Global();

  _getInfo() async {
    if (!isReload) {
      isReload = true;
      try {
        var response = await global.postFormData("about/query");
        Map<String, dynamic> data = DataResponse.fromJson(response).entity;
        setState(() {
          company_name = data['company_name'];
          company_tel = "联系电话：" + data['company_tel'];
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
