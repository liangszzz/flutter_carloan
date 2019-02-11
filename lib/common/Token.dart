import 'package:flutter_carloan/common/FileUtil.dart';

///token 文件存放信息
class Token {
  DateTime expire;

  String token;

  Token(this.expire, this.token);

  static Future<Token> loadToken() async {
    FileUtil fileUtil = FileUtil("token");
    var readStr = await fileUtil.read();
    Token token = parseToken(readStr);
    return token;
  }

  void writeToken() async {
    FileUtil fileUtil = FileUtil("token");
    fileUtil.write(this.toString());
  }

  static Token parseToken(String str) {
    var expire = str.substring(0, 23);
    var token = str.substring(23);
    return Token(DateTime.parse(expire), token);
  }

  String toString() {
    return expire.toIso8601String().substring(0, 23) + token;
  }

  /// true 未过期  false 过期
  bool checkExpire() {
    if (DateTime.now().isBefore(this.expire)) {
      return true;
    }
    return false;
  }
}
