import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/me/MeScene.dart';
import 'package:flutter_carloan/order/OrderPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

///  底部导航栏
class RootScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootSceneState();
}

class _RootSceneState extends State<RootScene> {
  Global global = new Global();
  int _tabIndex = 0;
  bool isFinishSetup = false;
  List<Image> _tabImages = [
    Image.asset('assets/images/record.png'),
    Image.asset('assets/images/mine_p.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('assets/images/record-active.png'),
    Image.asset('assets/images/mine-active.png'),
  ];


  @override
  void initState() {
    super.initState();
    setupApp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setupApp() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isFinishSetup = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isFinishSetup) {
      return Container();
    }

    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          OrderPage(
            idCard: global.user.idCard,
          ),
          MeScene(),
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Colors.red,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0), title: Text('借款记录')),
          BottomNavigationBarItem(icon: getTabIcon(1), title: Text('我的')),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }

  Image getTabIcon(int index) {
    if (index == _tabIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabImages[index];
    }
  }
}
