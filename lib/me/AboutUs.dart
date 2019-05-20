import 'package:flutter/material.dart';

///关于我们信息
class AboutUsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
              "乐颂融资租赁（深圳）有限公司",
              style: new TextStyle(fontSize: 20.0),
            ),
            new SizedBox(
              height: 30.0,
            ),
            new Text(
              "联系电话 ： 020-80929150",
              style: new TextStyle(fontSize: 16.0),
            )
          ],
        ));
  }
}
