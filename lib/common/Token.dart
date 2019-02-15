import 'package:flutter_carloan/common/FileUtil.dart';

///token 文件存放信息
class Token {
  DateTime expire;

  String token;

  Token(this.expire, this.token);

  static Future<Token> loadToken() async {
    FileUtil fileUtil = FileUtil("token");
    var readStr = await fileUtil.read();
    if (readStr != null) {
      return Token(
          DateTime.parse(readStr.substring(0, 23)), readStr.substring(23));
    }
    return null;
  }

  void writeToken() {
    FileUtil fileUtil = FileUtil("token");
    fileUtil.write(this.toString());
  }

  Token.parseToken(String str) {
    if (str != null && str.length > 23) {
      expire = DateTime.parse(str.substring(0, 23));
      token = str.substring(23);
    }
  }

  String toString() {
    if (expire != null && token != null) {
      return expire.toIso8601String().substring(0, 23) + token;
    }
    return "";
  }

  /// true 未过期  false 过期
  bool checkExpire() {
    if (expire != null && DateTime.now().isBefore(this.expire)) {
      return true;
    }
    return false;
  }
}
