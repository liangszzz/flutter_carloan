
import 'package:flutter_carloan/app/FileUtil.dart';

///token 文件存放信息
class Token {
  DateTime expire;

  String token;

  Token(this.expire, this.token);

  /// true 未过期  false 过期
  bool checkExpire() {
    if (expire != null && DateTime.now().isBefore(this.expire)) {
      return true;
    }
    return false;
  }
}
