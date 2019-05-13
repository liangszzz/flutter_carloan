import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/Global.dart';

class updateVersionPage extends StatefulWidget {
  updateVersionPage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _updateVersionPageState createState() => new _updateVersionPageState();
}

class _updateVersionPageState extends State<updateVersionPage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  AnimationController animationController;
  Animation animation;
  bool showing = false;
  bool first = true;

  Global global = Global();

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    animation = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      })
      ..addListener(() {
        if (!showing) {
          setState(() {});
        }
        //  setState(() {});
      });
    animationController.repeat();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  void didUpdateWidget(updateVersionPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (first == true) {
      Future.delayed(Duration.zero, () => showAlertDialog(context));
      first = false;
    }

    return new MaterialApp(
        home: new Scaffold(
      body: new Center(
          child: new Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(animation.value, animation.value),
            child: Image.asset(
              "assets/images/header.png",
              width: 21.0,
              height: 21.0,
              fit: BoxFit.fill,
            ),
          ),
          Transform.translate(
            offset: Offset(animation.value * 2, animation.value * 2),
            child: Image.asset(
              "assets/images/header.png",
              width: 21.0,
              height: 21.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      )),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showAlertDialog(context);
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ));
    // return
  }

  void showAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 10.0),
                  //width: 100,
                  height: 35,
                  child: Text('版本更新',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
                SizedBox(height: 20),
                Text("1.修改部分bug"),
                Text("2.页面样式优化"),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          actions: <Widget>[
            new Container(
              width: 250,
              child: _create(),
            )
          ], // 圆角
        );
      },
    );
  }

  Row _create() {
    //已读
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('确认更新',
                style: TextStyle(fontSize: 16, color: Colors.blue)),
            //可点击
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              var url = "/app/update";
              var response = await global.post(url);
            },
          ),
          SizedBox(
            width: 10.0,
          )
        ],
      );
  }
}
