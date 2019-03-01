import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/CommonButton.dart';
import 'package:flutter_carloan/app/DialogUtils.dart';
import 'package:flutter_carloan/common/DataResponse.dart';
import 'package:flutter_carloan/common/Global.dart';
import 'package:flutter_carloan/sign/SignPage.dart';
import 'package:image_picker/image_picker.dart';

///人脸识别
class faceValidatePage extends StatefulWidget {
  final String bizOrderNo;

  const faceValidatePage({Key key, this.bizOrderNo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _faceValidateState();
}

class _faceValidateState extends State<faceValidatePage> {
  Global global = new Global();

  bool faveCheck = false;

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

  _buildTitle() {
    return Text(
      "人脸检查",
      style: TextStyle(fontSize: 14),
    );
  }

  _buildBody() {
    var text = Text("请上传本人脸部清晰照片用于人脸识别");

    var photo = new Container(
        height: 250,
        child: GestureDetector(
          onTap: _selectImage,
        ),
        decoration: new BoxDecoration(
          image: DecorationImage(image: _getImageProvider(), fit: BoxFit.cover),
          border: new Border.all(width: 1.0, color: Colors.black38),
        ));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        children: <Widget>[
          text,
          SizedBox(
            height: 20,
          ),
          photo,
          SizedBox(
            height: 20,
          ),
          CommonButton(
            text: "下一步",
            onClick: _toNext,
          ),
        ],
      ),
    );
  }

  File _image;

  void _selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    _doLoading();
  }

  ImageProvider _getImageProvider() {
    if (_image != null) {
      return FileImage(_image);
    } else {
      return AssetImage("assets/images/add_face.png");
    }
  }

  void _doLoading() {
    DialogUtils.showLoadingDialog(context, null, function: _doCheck);
  }

  void _doCheck(Function f) async {
    if (_image == null) {
      DialogUtils.showAlertDialog(context, "提示", "请先选择图片", null,
          contentStyle: TextStyle(color: Colors.red));
      return;
    }
    var readAsStringSync = _image.readAsBytesSync();
    var base64encode = base64Encode(readAsStringSync);

    var response = await global.postFormData("face/verify", {
      "bizOrderNo": this.widget.bizOrderNo,
      "videoBase64String": base64encode
    });
    DataResponse dataResponse = DataResponse.fromJson(response);
    if (dataResponse.success()) {
      setState(() {
        faveCheck = true;
      });
      f();
      DialogUtils.showAutoCloseNoBtnDialog(context, "检测通过!", null);
    } else {
      f();
      DialogUtils.showAlertDialog(context, "提示", "人脸验证失败,请点击照片重新上传!", null,
          contentStyle: TextStyle(color: Colors.red));
    }
  }

  void _toNext() {
    if (faveCheck) {
      DialogUtils.showAutoCloseNoBtnDialog(context, "人脸识别成功!", () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          return SignPage(bizOrderNo: this.widget.bizOrderNo, channelType: 1);
        }));
      });
    } else {
      DialogUtils.showAlertDialog(context, "提示", "请先完成人脸识别!", null,
          contentStyle: TextStyle(color: Colors.red));
    }
  }
}
