import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carloan/carInfo/ClCarInfo.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/common/SysDict.dart';
import 'package:flutter_carloan/userInfo/ClAttachmentInfo.dart';
import 'package:flutter_carloan/userInfo/ClContactInfo.dart';
import 'package:flutter_carloan/userInfo/ClUserInfo.dart';
import 'package:flutter_carloan/userInfo/EditUserInfoPage.dart';
import 'package:flutter_carloan/userInfo/ShowPhoto.dart';

class CarInfoPage extends StatefulWidget {
  final String bizOrderNo;
  final int channelType;

  const CarInfoPage({Key key, this.bizOrderNo, this.channelType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _CarInfoPageState();
  }
}

class _CarInfoPageState extends State<CarInfoPage> {
  bool isReload = false;

  String carNo;
  String carBrand;
  String carModel;
  String carColor;
  String carFrameNo;
  String carEngineNo;
  String carServiceLife;
  String carDrivingMileage;
  double carCost;
  int majorAccident;

  int accidentTypeValue;
  String accidentTypeLabel;
  List accidentTypeList = new List();

  List<String> CarImageList = new List();
  List<String> registerImageList = new List();
  List<String> driveImageList = new List();
  List<String> lists = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542212557760&di=2c0ccc64ab23eb9baa5f6582e0e4f52d&imgtype=0&src=http%3A%2F%2Fpic.feizl.com%2Fupload%2Fallimg%2F170725%2F43998m3qcnyxwxck.jpg",
  ];


  @override
  Widget build(BuildContext context) {
    _getCarInfo(widget.bizOrderNo, widget.channelType);

    ///事故类型
    if (accidentTypeList.length > 0) {
      for (int i = 0; i < accidentTypeList.length; i++) {
        if (accidentTypeValue == int.parse(accidentTypeList[i].value)) {
          accidentTypeLabel = accidentTypeList[i].label;
        }
      }
    }

    List<Widget> list = <Widget>[
      new Container(
        height: 4.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('',
                  style: TextStyle(
                      fontSize: 12.0, color: const Color(0xffAAAAAA))),
            ),
          ],
        ),
      ),

      ///车牌号码
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '车牌号码',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$carNo",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onSubmitted: (text) {
                  carNo = text;
                },
              ),
            ),
          ],
        ),
      ),

      ///车辆品牌
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '车辆品牌',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$carBrand",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  onSubmitted: (text) {
                    carBrand = text;
                  },
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

      ///车辆型号
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '车辆型号',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$carModel",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onSubmitted: (text) {
                  carModel = text;
                },
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

      ///车辆估值(元)
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '车辆估值(元)',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$carCost",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                maxLines: 1,
                onSubmitted: (text) {
                  carNo = text;
                },
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

      ///车身颜色
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '车身颜色',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$carColor",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onSubmitted: (text) {
                  carColor = text;
                },
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

      ///车架号
      new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                '车架号',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
              ),
            ),
            new Expanded(
              child: TextField(
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "$carFrameNo",
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onSubmitted: (text) {
                  carFrameNo = text;
                },
              ),
            ),
          ],
        ),
      ),

      ///分割阴影
      new Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        height: 1.0,
        color: const Color(0xffebebeb),
      ),

      ///发动机号
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '发动机号',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$carEngineNo",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  onSubmitted: (text) {
                    carEngineNo = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///车辆使用年限
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '车辆使用年限',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$carServiceLife",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  onSubmitted: (text) {
                    carServiceLife = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///行驶里程
      new GestureDetector(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '行驶里程',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "$carDrivingMileage",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  onSubmitted: (text) {
                    carDrivingMileage = text;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      ///是否有重大事故
      new GestureDetector(
        onTap: _showMajorAccidentDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '是否有过重大事故',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  majorAccident == 1 ? '有': '无',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xff353535)),
                ),
              ),
            ],
          ),
        ),
      ),

      ///事故类型
      new GestureDetector(
        onTap: _showCheckAccidentTypeDialog,
        child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          height: 48.0,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  '事故类型',
                  style:
                      TextStyle(fontSize: 16.0, color: const Color(0xffAAAAAA)),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new Text(
                  '$accidentTypeLabel',
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

      ///车辆照片
      new Container(
        height: 50.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('      车辆照片',
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
            ),
          ],
        ),
      ),

      new Container(
        height: 120.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new SafeArea(
                top: false,
                bottom: false,
                child: new GridView.count(
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(4.0),
                  childAspectRatio: 1.5,
                  children: CarImageList.map((f) {
                    return new GestureDetector(
                      onTap: () {
                        var index;
                        if(CarImageList.contains(f)){
                          index = CarImageList.indexOf(f);
                        }
                        showPhoto(context,f,index);
                      },
                      child: Image.network(f,fit: BoxFit.cover,),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),

      ///机动车登记证/抵押证
      new Container(
        height: 50.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('      机动车登记证/抵押证',
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
            ),
          ],
        ),
      ),

      new Container(
        height: 120.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new SafeArea(
                top: false,
                bottom: false,
                child: new GridView.count(
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(4.0),
                  childAspectRatio: 1.5,
                  children: registerImageList.map((f) {
                    return new GestureDetector(
                      onTap: () {
                        var index;
                        if(registerImageList.contains(f)){
                          index = registerImageList.indexOf(f);
                        }
                        showPhoto(context,f,index);
                      },
                      child: Image.network(f,fit: BoxFit.cover,),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),

      ///行驶证
      new Container(
        height: 50.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text('      行驶证',
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
            ),
          ],
        ),
      ),

      new Container(
        height: 120.0,
        color: const Color(0xffebebeb),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new SafeArea(
                top: false,
                bottom: false,
                child: new GridView.count(
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(4.0),
                  childAspectRatio: 1.5,
                  children: driveImageList.map((f) {
                    return new GestureDetector(
                      onTap: () {
                        var index;
                        if(driveImageList.contains(f)){
                          index = driveImageList.indexOf(f);
                        }
                        showPhoto(context,f,index);
                      },
                      child: Image.network(f,fit: BoxFit.cover,),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
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

      ///按钮
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
            '车辆信息',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: new Center(
          child: new ListView(children: list),
        ));
  }

  Global global = Global();
  _getCarInfo(String bizOrderNo, int channelType) async {
    if (!isReload) {
      isReload = true;
      try {
        Map<String, Object> dataMap = new Map();
        ClCarInfo clCarInfo;
        List carList = new List();
        List registerList = new List();
        List accidentStatusList = new List();
        List carDriveList = new List();
        var response = await global.postFormData("car/query",
            {"biz_order_no": bizOrderNo, "channel_type": channelType});
        dataMap = response['dataMap'];
        clCarInfo = ClCarInfo.fromJson(dataMap['clCarInfo']);
        carList = dataMap["carList"];
        registerList = dataMap['registerList'];
        accidentStatusList = dataMap['accidentTypes'];
        carDriveList = dataMap['cardriveListList'];
        Map riskData = dataMap['clRiskInfo'] as Map;

        setState(() {
          carNo = clCarInfo.car_no;
          carBrand = clCarInfo.car_brand;
          carModel = clCarInfo.car_model;
          carColor = clCarInfo.car_color;
          carFrameNo = clCarInfo.car_frame_no;
          carEngineNo = clCarInfo.car_engine_no;
          carDrivingMileage = clCarInfo.car_driving_mileage;
          carServiceLife = clCarInfo.car_service_life;
          accidentTypeValue = int.parse(clCarInfo.accident_type);
          majorAccident = int.parse(clCarInfo.major_accident);
          carCost = riskData['car_cost'];

          ///车辆照片
          for (int i = 0; i < carList.length; i++) {
            String filePath = carList[i]['file_path'];
            CarImageList.add(filePath);
          }

          ///登记证，抵押证
          for (int i = 0; i < registerList.length; i++) {
            String filePath = registerList[i]['file_path'];
            registerImageList.add(filePath);
          }

          ///行驶证
          for (int i = 0; i < carDriveList.length; i++) {
            String filePath = carDriveList[i]['file_path'];
            driveImageList.add(filePath);
          }

          ///事故类型
          List<SysDict> accidents = new List();
          for (int i = 0; i < accidentStatusList.length; i++) {
            SysDict sysDict = new SysDict();
            sysDict.label = accidentStatusList[i]["label"];
            sysDict.value = accidentStatusList[i]["value"];
            accidents.add(sysDict);
          }
          accidentTypeList = accidents;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  /// 展示选择事故类型的弹窗
  _showCheckAccidentTypeDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new ListView(
                  children: listViewDefault(accidentTypeList,
                      "accident_type_flag", accidentTypeValue)),
            ),
            /* children: listViewDefault(),*/
          );
        });
  }

  ///是否有无事故
  void _showMajorAccidentDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              width: 300.0,
              height: 230.0,
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new RadioListTile<int>(
                    title: const Text('无'),
                    value: 0,
                    groupValue: majorAccident,
                    onChanged: (int e) =>
                        updateDefaultDialogValue(e, 'major_accident_flag'),
                  ),
                  new RadioListTile<int>(
                    title: const Text('有'),
                    value: 1,
                    groupValue: majorAccident,
                    onChanged: (int e) =>
                        updateDefaultDialogValue(e, "major_accident_flag"),
                  ),
                ],
              ),
            ),
          );
        }); /* children: listViewDefault(),*/
  }

  ///公共弹窗
  listViewDefault(List sysDictList, String type, int dataValue) {
    List<Widget> data = new List();
    for (int i = 0; i < sysDictList.length; i++) {
      data.add(
        new RadioListTile<int>(
          title: new Text(sysDictList[i].label),
          value: int.parse(sysDictList[i].value),
          groupValue: dataValue,
          onChanged: (int e) => updateDefaultDialogValue(e, type),
        ),
      );
    }

    return data;
  }

  ///公共弹窗返回值
  updateDefaultDialogValue(int e, String type) {
    Navigator.pop(context);
    setState(() {
      switch (type) {
        case 'accident_type_flag':
          this.accidentTypeValue = e;
          break;
        case 'major_accident_flag':
          this.majorAccident = e;
          break;
      }
    });
  }

  ///图片预览
  void showPhoto(BuildContext context, String f, index) {
    Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
                title: Text('图片预览')
            ),
            body: SizedBox.expand(
              child: Hero(
                tag: index,
                child: new ShowPhotoPage(url:f),
              ),
            ),
          );
        }
    ));
  }
}
