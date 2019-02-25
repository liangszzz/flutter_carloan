import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/login/LoginPage.dart';
import 'package:flutter_carloan/me/MeScene.dart';
import 'package:flutter_carloan/order/OrderPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RootScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RootSceneState();
}

class RootSceneState extends State<RootScene> {
  int _tabIndex = 0;
  bool isFinishSetup = false;
  List<Image> _tabImages = [
    Image.asset('img/tab_bookshelf_n.png'),
    Image.asset('img/tab_me_n.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('img/tab_bookshelf_p.png'),
    Image.asset('img/tab_me_p.png'),
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
            idCard: '341203197307200711',
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
