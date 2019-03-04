import 'package:flutter/material.dart';

class FormUtils {
  ///创建一个表单
  static Form createForm(child,
      {bool autoValidate = true,
      Key formKey,
      VoidCallback onWillPop,
      VoidCallback onChanged}) {
    var form = Form(
      key: formKey,
      autovalidate: autoValidate,
      onWillPop: onWillPop,
      onChanged: onChanged,
      child: child,
    );
    return form;
  }

  ///创建表单已一行
  static void createTextRow(
      TextEditingController controller, {TextInputType keyboardType}) {
    var text = TextFormField(
      controller: controller,
      keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
    );


   var row= new Container(
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
//                hintText: "$carNo",
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
              maxLines: 1,
              onSubmitted: (text) {
//                carNo = text;
              },
            ),
          ),
        ],
      ),
    );

  }
}
