class DataResponse {
  ///0 成功 1 失败
  int code;

  ///msg
  String msg;

  ///数量
  int count;

  List<Object> data;

  Object entity;

  Map<String, Object> dataMap;

  ///将json转换为对象
  DataResponse.fromJson(Map json) {
    code = json["code"];
    msg = json["msg"];
    count = json["count"];
    data = json["data"];
    entity = json["entity"];
    dataMap = json["dataMap"];
  }
  ///是否成功
  bool success() {
    if (code == 0) {
      return true;
    }
    return false;
  }
}
