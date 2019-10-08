import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carloan/app/DataResponse.dart';
import 'package:flutter_carloan/app/Global.dart';
import 'package:flutter_carloan/common/CommonButton.dart';
import 'package:flutter_carloan/common/DialogUtils.dart';
import 'package:image_picker/image_picker.dart';

///更新个人信息
class UpdateUserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpdateUserInfoPageState();
}

class _UpdateUserInfoPageState extends State<UpdateUserInfoPage> {
  Global global = new Global();

  TextEditingController _nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: _buildBody(),
      ));

  Widget _buildTitle() {
    return Text("修改个人信息", style: TextStyle(fontSize: 16));
  }

  @override
  void initState() {
    super.initState();
    _nickNameController.text = global.user.nickName;
  }

  @override
  void dispose() {
    super.dispose();
    _nickNameController.dispose();
  }

  Widget _buildBody() {
    var headImg = Container(
      child: GestureDetector(
        onTap: () {
          showModalBottomSheetDialog(context);
        },
        child: CircleAvatar(
          radius: 50,
          backgroundImage: _getImageProvider(),
        ),
      ),
    );

    var nick = TextFormField(
      controller: _nickNameController,
      maxLength: 50,
      maxLengthEnforced: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "昵称",
        hintText: "请输入昵称",
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          headImg,
          SizedBox(
            height: 20,
          ),
          nick,
          SizedBox(
            height: 20,
          ),
          _buildBtn(),
        ],
      ),
    );
  }

  ///创建修改按钮
  Widget _buildBtn() {
    return CommonButton(text: "确认", onClick: _updateInfo);
  }

  ///上传图片,修改信息
  void _updateInfo() async {
    if (_nickNameController.text.isEmpty ||
        _nickNameController.text.length > 50) {
      DialogUtils.showAlertDialog(context, "提示", "请填写昵称!", null,
          contentStyle: TextStyle(color: Colors.red));
      return;
    }
    FormData formData = new FormData.from(
        {"nickName": _nickNameController.text, "phone": global.user.phone});
    if (_image != null) {
      formData.add("file", new UploadFileInfo(_image, "1.png"));
    }

    var response =
        await global.postFormData("appUser/updateUserInfo", formData);
    DataResponse d = DataResponse.fromJson(response);
    if (d.success()) {
      setState(() {
        global.user.nickName = _nickNameController.text;
        if (_image != null && d.entity != null) {
          global.user.avatarUrl = d.entity;
        }
      });
      DialogUtils.showAlertDialog(context, "提示", "修改成功!", null);
      return;
    }
  }

  File _image;

  showModalBottomSheetDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text("相机", textAlign: TextAlign.left),
                onTap: () {
                  _selectPhoneImage();
                  Navigator.pop(context);
                },
              ),
              new Container(
                height: 1.0,
                color: Colors.grey,
              ),
              new ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text("相册", textAlign: TextAlign.left),
                onTap: () {
                  _selectGalleryImage();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  ImageProvider _getImageProvider() {
    if (_image != null) {
      return FileImage(_image);
    } else {
      if (global.user.avatarUrl == null || global.user.avatarUrl == '') {
        return AssetImage("assets/images/header.png");
      }
      return NetworkImage(global.user.avatarUrl);
    }
  }

  Future _selectPhoneImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: global.imageQuality);
    setState(() {
      _image = image;
    });
  }

  Future _selectGalleryImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: global.imageQuality);
    setState(() {
      _image = image;
    });
  }
}
